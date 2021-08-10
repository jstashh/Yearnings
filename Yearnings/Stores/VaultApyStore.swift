//
//  VaultApyStore.swift
//  Yearnings
//
//

import Foundation
import Combine

protocol VaultApyStoreProtocol {
    func fetchAllApys() -> AnyPublisher<[YearnVault], Never>
}

final class VaultApyStore: VaultApyStoreProtocol {

    static let key = "com.yearnings.vaultContainerKey"

    private var cancellables = Set<AnyCancellable>()

    @Published var vaults: [YearnVault] = []
    private let reload = PassthroughSubject<Void, Never>()

    init() {}

    func fetchAllApys() -> AnyPublisher<[YearnVault], Never> {
        if let cached = UserDefaults.standard.object(forKey: Self.key) as? Data, let container = try? JSONDecoder().decode(YearnVaultsContainer.self, from: cached) {
            let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            if container.fetchedAt > oneDayAgo {
                return Just(container.vaults)
                    .setFailureType(to: Never.self)
                    .eraseToAnyPublisher()
            }
        }

        return URLSession.shared.dataTaskPublisher(for: Externals.yearnApyUrl)
            .tryMap({ data, response in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw YearningsError.httpError(statusCode: response.statusCode)
                }
                return data
            })
            .decode(type: [YearnVaultDTO].self, decoder: JSONDecoder())
            .map { dtos in
                let result = dtos.map { YearnVault(dto: $0) }
                let container = YearnVaultsContainer(vaults: result)
                if let data = try? JSONEncoder().encode(container) {
                    UserDefaults.standard.set(data, forKey: Self.key)
                }
                return result
            }
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}

struct YearnVault: Codable {
    let apy: Double
    let address: String

    fileprivate init(dto: YearnVaultDTO) {
        self.apy = dto.apy?.recommended ?? .zero
        self.address = dto.address.lowercased()
    }
}

private struct YearnVaultDTO: Codable {
    let apy: Apy?
    let address: String
}

private struct Apy: Codable {
    let recommended: Double
}

private struct YearnVaultsContainer: Codable {
    let vaults: [YearnVault]
    let fetchedAt: Date

    init(vaults: [YearnVault]) {
        self.vaults = vaults
        self.fetchedAt = Date()
    }
}
