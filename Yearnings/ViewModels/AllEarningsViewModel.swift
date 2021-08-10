//
//  AllEarningsViewModel.swift
//  Yearnings
//

//

import Foundation
import Combine
import SwiftUI

final class AllEarningsViewModel: ObservableObject {

    typealias Stores = EthPriceStoreProvider
        & NetworkProvider
        & VaultApyStoreProvider

    @Published var viewModels: [VaultEarningsViewModel] = []
    @Published var appError: YearningsErrorType?
    @Published var aggregatedApy: Double = .zero
    @Published private var ethPrice: Double = .zero
    @Published private var vaults: [YearnVault] = []
    let reload = PassthroughSubject<[Address], Never>()
    private let calculateApy = PassthroughSubject<Void, Never>()
    private var lastReloaded: Date?

    var aggregatedApyStr: String {
        NumberFormatter.percentageFormatter.string(from: aggregatedApy)
    }

    var estimatedEarningsPerDay: String {
        let result = aggregatedApy * viewModels.map { $0.balanceUsdc }.reduce(0, +) / 365
        return NumberFormatter.usdFormatter.string(from: result)
    }

    var cancellables = Set<AnyCancellable>()

    var totalEarningsEth: String {
        guard ethPrice != .zero || ethPrice != .nan else {
            return ""
        }
        let number = viewModels.map { $0.earningsInUsdc }.reduce(0, +) / ethPrice
        return NumberFormatter.ethFormatter.string(from: number)
    }

    var totalEarningsUsdc: String {
        let number = viewModels.map { $0.earningsInUsdc }.reduce(0, +)
        return NumberFormatter.usdFormatter.string(from: number)
    }

    var netWorthEth: String {
        guard ethPrice != .zero || ethPrice != .nan else {
            return ""
        }
        let number = viewModels.map { $0.balanceUsdc }.reduce(0, +)  / ethPrice
        return NumberFormatter.ethFormatter.string(from: number)
    }

    var netWorthUsdc: String {
        NumberFormatter.usdFormatter.string(from: totalBalanceUsdc)
    }

    private var totalBalanceUsdc: Double {
        viewModels.map { $0.balanceUsdc }.reduce(0, +)
    }

    private let stores: Stores

    init(stores: Stores) {
        self.stores = stores
        stores.ethPriceStore.ethPrice()
            .assign(to: \.ethPrice, on: self)
            .store(in: &cancellables)

        reload
            .sink(receiveValue: { [weak self] in self?.fetchViewModels(addresses: $0) })
            .store(in: &cancellables)

        stores.vaultApyStore.fetchAllApys()
            .assign(to: \.vaults, on: self)
            .store(in: &cancellables)

        $vaults
            .sink { [weak self] _ in
                self?.calculateApy.send()
            }
            .store(in: &cancellables)

        calculateApy
            .debounce(for: 0.4, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.calculate()
            }
            .store(in: &cancellables)
    }

    private func calculate() {
        self.aggregatedApy = (self.calculateAggregatedApy(viewModels: viewModels, vaults: vaults) ?? .zero)
    }

    private func calculateAggregatedApy(viewModels: [VaultEarningsViewModel], vaults: [YearnVault]) -> Double? {
        guard !viewModels.isEmpty, !vaults.isEmpty else {
            return nil
        }

        let totalBalanceUsdc = self.totalBalanceUsdc

        guard totalBalanceUsdc != .zero else {
            return nil
        }

        return viewModels.reduce(Double.zero) { result, viewModel in
            guard let apy = vaults.first(where: { $0.address == viewModel.vaultAddress })?.apy else {
                return result
            }
            let ratio = viewModel.balanceUsdc / totalBalanceUsdc
            let weightedApy = ratio * apy
            return result + weightedApy
        }
    }

    private func fetchViewModels(addresses: [Address]) {
        if let lastReloaded = lastReloaded, lastReloaded > Date().addingTimeInterval(-30) {
            return
        }
        stores.network.fetchEarnings(addresses: addresses)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.appError = YearningsErrorType(error: error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] viewModels in
                self?.lastReloaded = Date()
                self?.handleViewModels(viewModels: viewModels)
            })
            .store(in: &cancellables)
    }

    private func handleViewModels(viewModels: [VaultEarningsViewModel]) {
        for viewModel in viewModels {
            cancellables.insert(viewModel.objectWillChange.sink(receiveValue: { [weak self] _ in
                self?.objectWillChange.send()
            }))

            cancellables.insert(viewModel.objectWillChange.sink(receiveValue: { [weak self] _ in
                self?.calculateApy.send()
            }))
        }
        self.viewModels = viewModels.sorted(by: { $0.tokenSymbol > $1.tokenSymbol })
    }

}
