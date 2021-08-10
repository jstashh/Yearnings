//
//  VaultHistoricalUpdates.swift
//  Yearnings
//
//

import Foundation
import BigInt

struct VaultHistoricalUpdates {
    let date: Date
    let pricePerShare: BigInt

    init(graphqlUpdate: AccountHistoricEarningsQuery.Data.Account.VaultPosition.Vault.VaultDayDatum) {
        self.date = Date(timeIntervalSince1970: Double(graphqlUpdate.date))
        self.pricePerShare = BigInt(graphqlUpdate.pricePerShare)!
    }
}
