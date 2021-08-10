//
//  VaultEarningsViewModel.swift
//  Yearnings
//

//

import Foundation
import BigInt
import SwiftUI
import Combine

final class VaultEarningsViewModel: ObservableObject, Identifiable {

    typealias Stores = Web3StoreProvider
        & VaultAliasStoreProvider
        & ImageStoreProvider
        & USDCPriceOracleProvider
        & NetworkProvider
        & UserAddressStoreProvider

    let id = UUID()

    @Published var tokenIcon: UIImage = UIImage()
    @Published var vaultName: String = ""
    @Published var historicalEarningsData: [(String, Double)] = []
    @Published var isLoadingHistoricalEarningsData: Bool = false
    @Published private var tokenUsdcPrice: BigUInt = .zero

    var earningsInUsdc: Double {
        let earningsUsdc = earnings.multiplied(by: tokenUsdcPrice) / BigUInt(10).power(.usdcDecimalPlaces)
        return earningsUsdc.doubleValue(tokenDecimals: vaultUserData.token.decimals)
    }

    var balanceUsdc: Double {
        let balance = vaultUserData.currentBalance.multiplied(by: tokenUsdcPrice) / BigUInt(10).power(.usdcDecimalPlaces)
        return balance.doubleValue(tokenDecimals: vaultUserData.token.decimals)
    }

    var earningsInUsdcText: String {
        NumberFormatter.usdFormatter.string(from: earningsInUsdc)
    }

    var earningsNativeText: String {
        NumberFormatter.nativeFormatter.string(from: earnings.doubleValue(tokenDecimals: vaultUserData.token.decimals))
    }

    var depositedNativeText: String {
        NumberFormatter.nativeFormatter.string(from: vaultUserData.currentBalance.doubleValue(tokenDecimals: vaultUserData.token.decimals))
    }

    var depositedUsdcText: String {
        let depositedUsdc = vaultUserData.currentBalance.multiplied(by: tokenUsdcPrice) / BigUInt(10).power(.usdcDecimalPlaces)
        let double = depositedUsdc.doubleValue(tokenDecimals: vaultUserData.token.decimals)
        return NumberFormatter.usdFormatter.string(from: double)
    }

    private lazy var earnings: BigUInt = {
        let positiveTokens = vaultUserData.currentBalance
            + vaultUserData.tokensSent
            + vaultUserData.tokensWithdrawn

        let negativeTokens = vaultUserData.tokensDeposited
            + vaultUserData.tokensReceived

        guard positiveTokens > negativeTokens else {
            // likely a negligible rounding error
            return .zero
        }

        return positiveTokens - negativeTokens
    }()

    private var cancellables = Set<AnyCancellable>()
    private let vaultUserData: VaultUserData
    private let stores: Stores
    let vaultAddress: String
    let tokenSymbol: String

    init(
        vaultUserData: VaultUserData,
        stores: Stores
    ) {
        self.vaultUserData = vaultUserData
        self.stores = stores
        self.vaultAddress = vaultUserData.vaultAddress.value
        self.tokenSymbol = vaultUserData.token.symbol

        stores.vaultAliasStore.getAlias(forTokenWithAddress: vaultUserData.token.address)
            .replaceNil(with: vaultUserData.shareToken.symbol)
            .assign(to: \.vaultName, on: self)
            .store(in: &cancellables)

        let url = Externals.tokenIconURL(tokenAddress: vaultUserData.token.address)
        stores.imageStore.loadImage(fromUrl: url)
            .assign(to: \.tokenIcon, on: self)
            .store(in: &cancellables)

        stores.usdcPriceOracle.fetchPrice(forTokenAddress: vaultUserData.token.address, shareTokenAddress: vaultUserData.shareToken.address)
            .replaceError(with: .zero)
            .sink(receiveValue: { [weak self] tokenPriceUsd in
                self?.tokenUsdcPrice = tokenPriceUsd
                self?.objectWillChange.send()
            })
            .store(in: &cancellables)
    }

    func fetchHistoricalEarningsData() {
        isLoadingHistoricalEarningsData = true
        let oneMonthAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
        stores.network.fetchHistoricEarnings(
            addresses: stores.userAddressStore.addresses.map { $0.value },
            shareTokenAddress: vaultUserData.shareToken.address.value,
            from: oneMonthAgo
        )
        .replaceError(with: VaultPositionHistoricEarningsViewModel(vaultPositionUpdates: [], shareTokenDecimals: 0, vaultHistoricalUpdates: []))
        .sink(receiveValue: { [weak self] viewModel in
            self?.historicalEarningsData = viewModel.data
            self?.objectWillChange.send()
            self?.isLoadingHistoricalEarningsData = false
        })
        .store(in: &cancellables)
    }
}
