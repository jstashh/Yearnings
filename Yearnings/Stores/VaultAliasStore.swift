//
//  VaultAliasStore.swift
//  Yearnings
//

//

import Foundation
import Combine

protocol VaultAliasStoreProtocol {
    func getAlias(forTokenWithAddress: Address) -> AnyPublisher<String?, Never>
}

final class VaultAliasStore: VaultAliasStoreProtocol {

    private let vaultAliases = CurrentValueSubject<[VaultAlias], Never>([])
    private var cancellables = Set<AnyCancellable>()

    init() {
        let url = Externals.vaultAliasURL
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ data, response in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw YearningsError.httpError(statusCode: response.statusCode)
                }
                return data
            })
            .decode(type: [VaultAlias].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] aliases in
                self?.vaultAliases.send(aliases)
            })
            .store(in: &cancellables)
    }

    func getAlias(forTokenWithAddress address: Address) -> AnyPublisher<String?, Never> {
        vaultAliases
            .map({ $0.first(where: { $0.address.caseInsensitiveCompare(address.value) == .orderedSame })?.symbol })
            .eraseToAnyPublisher()
    }
}
