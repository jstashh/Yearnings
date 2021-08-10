//
//  EthPriceStore.swift
//  Yearnings
//

//

import Foundation
import Combine
import BigInt

protocol EthPriceStoreProtocol {
    func ethPrice() -> AnyPublisher<Double, Never>
    func ethPrice() -> AnyPublisher<BigUInt, Never> 
}

final class EthPriceStore: EthPriceStoreProtocol {

    private struct Response: Decodable {

        struct EthereumPrice: Decodable {
            let usd: Double
        }

        let ethereum: EthereumPrice
    }

    private var cancellables = Set<AnyCancellable>()
    private let reload = PassthroughSubject<Void, Never>()
    @Published var price: Double = 0

    init() {
        reload
            .throttle(for: 60, scheduler: DispatchQueue.main, latest: false)
            .sink(receiveValue: { [weak self] in self?.fetchEthPrice() })
            .store(in: &cancellables)
    }

    func ethPrice() -> AnyPublisher<Double, Never> {
        reload.send()
        return $price.eraseToAnyPublisher()
    }

    func ethPrice() -> AnyPublisher<BigUInt, Never> {
        ethPrice()
            .map { $0 * pow(10, 6) }
            .map { BigUInt($0) }
            .eraseToAnyPublisher()
    }

    private func fetchEthPrice() {
        URLSession.shared.dataTaskPublisher(for: Externals.coinGeckoURL)
            .tryMap({ data, response in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw YearningsError.httpError(statusCode: response.statusCode)
                }
                return data
            })
            .decode(type: Response.self, decoder: JSONDecoder())
            .map { $0.ethereum.usd }
            .replaceError(with: 1)
            .receive(on: DispatchQueue.main)
            .assign(to: \.price, on: self)
            .store(in: &cancellables)
    }
}
