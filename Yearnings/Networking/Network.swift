//
//  Network.swift
//  Yearnings
//
//

import Foundation
import Apollo
import Combine

protocol NetworkProtocol {
    func fetchEarnings(addresses: [Address]) -> AnyPublisher<[VaultEarningsViewModel], YearningsError>
    func fetchHistoricEarnings(addresses: [String], shareTokenAddress: String, from date: Date) -> AnyPublisher<VaultPositionHistoricEarningsViewModel, YearningsError>
}

final class Network: NetworkProtocol {
    private lazy var apollo = ApolloClient(url: Externals.subgraphURL)
    private var cancellables = Set<AnyCancellable>()

    func fetchEarnings(addresses: [Address]) -> AnyPublisher<[VaultEarningsViewModel], YearningsError> {
        Future<[VaultEarningsViewModel], YearningsError> { promise in
            self.apollo.fetch(query: AccountEarningsQuery(ids: addresses.map { $0.value })) { result in
                switch result {
                case .success(let data):
                    let vaultUserData = VaultUserDataFactory.makeVaultUserData(fromAccountEarningsData: data)
                    let viewModels = vaultUserData.map { VaultEarningsViewModel(vaultUserData: $0, stores: AllStores.shared) }
                    promise(.success(viewModels))
                case .failure(let error):
                    promise(.failure(YearningsError.graphqlError(error: error)))
                }
            }
        }.eraseToAnyPublisher()
    }

    func fetchHistoricEarnings(
        addresses: [String],
        shareTokenAddress: String,
        from date: Date
    ) -> AnyPublisher<VaultPositionHistoricEarningsViewModel, YearningsError> {
        return Future<VaultPositionHistoricEarningsViewModel, YearningsError> { promise in
            let query = AccountHistoricEarningsQuery(
                ids: addresses,
                shareToken: shareTokenAddress,
                fromDate: Int(date.timeIntervalSince1970)
            )
            self.apollo.fetch(query: query) { result in
                switch result {
                case .success(let data):
                    guard let vaultPositions = data.data?.accounts.compactMap ({ $0.vaultPositions.first }) else {
                        promise(.failure(YearningsError.accountVaultPositionNotFound))
                        return
                    }

                    let viewModel = vaultPositions.reduce(VaultPositionHistoricEarningsViewModel.empty) { result, vaultPosition in
                        let vaultPositionUpdates = vaultPosition.updates.map { AccountVaultPositionUpdate(graphqlUpdate: $0) }
                        let vaultHistoricalUpdates = vaultPosition.vault.vaultDayData.map { VaultHistoricalUpdates(graphqlUpdate: $0) }
                        let viewModel = VaultPositionHistoricEarningsViewModel(
                            vaultPositionUpdates: vaultPositionUpdates,
                            shareTokenDecimals: vaultPosition.token.decimals,
                            vaultHistoricalUpdates: vaultHistoricalUpdates
                        )
                        return result.merge(withOtherViewModel: viewModel)
                    }

                    promise(.success(viewModel))

                case .failure(let error):
                    promise(.failure(YearningsError.graphqlError(error: error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}

private extension VaultPositionHistoricEarningsViewModel {
    func merge(withOtherViewModel other: VaultPositionHistoricEarningsViewModel) -> VaultPositionHistoricEarningsViewModel {
        let vaultPositionUpdates = self.vaultPositionUpdates + other.vaultPositionUpdates
        let vaultHistoricalUpdates = (self.vaultHistoricalUpdates + other.vaultHistoricalUpdates).sorted { $0.date < $1.date }
        return VaultPositionHistoricEarningsViewModel(
            vaultPositionUpdates: vaultPositionUpdates,
            shareTokenDecimals: other.shareTokenDecimals,
            vaultHistoricalUpdates:  vaultHistoricalUpdates
        )
    }

    static var empty = VaultPositionHistoricEarningsViewModel(
        vaultPositionUpdates: [],
        shareTokenDecimals: 0,
        vaultHistoricalUpdates: []
    )
}
