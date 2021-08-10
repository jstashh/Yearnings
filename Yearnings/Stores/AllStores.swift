//
//  AllStoresStore.swift
//  Yearnings
//

//

import Foundation

protocol ImageStoreProvider {
    var imageStore: ImageStoreProtocol { get }
}

protocol VaultAliasStoreProvider {
    var vaultAliasStore: VaultAliasStoreProtocol { get }
}

protocol UserAddressStoreProvider {
    var userAddressStore: UserAddressStoreProtocol { get }
}

protocol EthPriceStoreProvider {
    var ethPriceStore: EthPriceStoreProtocol { get }
}

protocol Web3StoreProvider {
    var web3Store: Web3StoreProtocol { get }
}

protocol USDCPriceOracleProvider {
    var usdcPriceOracle: USDCPriceOracleProtocol { get }
}

protocol NetworkProvider {
    var network: NetworkProtocol { get }
}

protocol VaultApyStoreProvider {
    var vaultApyStore: VaultApyStoreProtocol { get }
}

final class AllStores {
    static let shared = AllStores()

    private static var _imageStore = ImageStore()
    private static var _vaultAliasStore = VaultAliasStore()
    private static var _userAddressStore = UserAddressStore()
    private static var _ethPriceStore = EthPriceStore()
    private static var _web3Store = Web3Store()
    private static var _usdcPriceOracle = USDCPriceOracle(ethPriceStore: _ethPriceStore, web3Store: _web3Store)
    private static var _network = Network()
    private static var _vaultApyStore = VaultApyStore()
}

extension AllStores: VaultAliasStoreProvider {
    var vaultAliasStore: VaultAliasStoreProtocol {
        Self._vaultAliasStore
    }
}

extension AllStores: ImageStoreProvider {
    var imageStore: ImageStoreProtocol {
        Self._imageStore
    }
}

extension AllStores: UserAddressStoreProvider {
    var userAddressStore: UserAddressStoreProtocol {
        Self._userAddressStore
    }
}

extension AllStores: EthPriceStoreProvider {
    var ethPriceStore: EthPriceStoreProtocol {
        Self._ethPriceStore
    }
}

extension AllStores: Web3StoreProvider {
    var web3Store: Web3StoreProtocol {
        Self._web3Store
    }
}

extension AllStores: USDCPriceOracleProvider {
    var usdcPriceOracle: USDCPriceOracleProtocol {
        Self._usdcPriceOracle
    }
}

extension AllStores: NetworkProvider {
    var network: NetworkProtocol {
        Self._network
    }
}

extension AllStores: VaultApyStoreProvider {
    var vaultApyStore: VaultApyStoreProtocol {
        Self._vaultApyStore
    }
}
