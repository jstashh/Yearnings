//
//  Externals.swift
//  Yearnings
//

//

import Foundation

enum Externals {
    static let vaultAliasURL = URL(string: "https://raw.githubusercontent.com/iearn-finance/yearn-assets/master/icons/aliases.json")!
    static let infuraRpcURL = "https://mainnet.infura.io/v3/0fa79a29ebe3426a95ca8a74690a31ac"
    static let usdPriceOracleAddress = "0xd3ca98D986Be88b72Ff95fc2eC976a5E6339150d"
    static let backupUsdPriceOracleAddress = "0x14d6E0908baE40A2487352B2a9Cb1A6232DA8785"
    static let subgraphURL = URL(string: "https://api.thegraph.com/subgraphs/name/tomprsn/yearn-vaults-v2-subgraph-mainnet")!
    static let coinGeckoURL = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd")!
    static let githubIssuesURL = URL(string: "https://github.com/jstashh/Yearnings/issues")!
    static let twitterURL = URL(string: "https://twitter.com/tom0pearson")!
    static let yearnApyUrl = URL(string: "https://vaults.finance/all")!
    static func tokenIconURL(tokenAddress: Address) -> URL {
        URL(string: "https://raw.githubusercontent.com/iearn-finance/yearn-assets/master/icons/tokens/\(tokenAddress.checksummed)/logo-128.png")!
    }

    static let eCRVVaultAddress = "0x986b4aff588a109c09b50a03f42e4110e29d353f"
    static let crvSTETHVaultAddress = "0xdcd90c7f6324cfa40d7169ef80b12031770b4325"
    static let WETHVaultAddress = "0xa9fe4601811213c340e850ea305481aff02f5b28"
    static var ethEquivalentVaultAddresses: [String] {
        [
            eCRVVaultAddress,
            crvSTETHVaultAddress,
            WETHVaultAddress
        ]
    }
}
