//
//  AccountVaultPositionUpdate.swift
//  Yearnings
//
//

import Foundation
import BigInt

struct AccountVaultPositionUpdate {
    
    let timeStamp: Date
    let balanceShares: BigInt
    let deposits: BigInt
    let withdrawals: BigInt
    let tokensReceived: BigInt
    let tokensSent: BigInt

    init(graphqlUpdate: AccountHistoricEarningsQuery.Data.Account.VaultPosition.Update) {
        self.timeStamp = Date(timeIntervalSince1970: Double(graphqlUpdate.timestamp )! / 1000)
        self.balanceShares = BigInt(graphqlUpdate.balanceShares)!
        self.deposits = BigInt(graphqlUpdate.deposits)!
        self.withdrawals = BigInt(graphqlUpdate.withdrawals)!
        self.tokensReceived = BigInt(graphqlUpdate.tokensReceived)!
        self.tokensSent = BigInt(graphqlUpdate.tokensSent)!
    }
}
