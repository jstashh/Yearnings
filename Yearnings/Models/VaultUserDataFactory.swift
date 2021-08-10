//
//  VaultUserDataFactory.swift
//  Yearnings
//

//

import Foundation
import Apollo
import BigInt

final class VaultUserDataFactory {
    static func makeVaultUserData(fromAccountEarningsData accountEarningsData: GraphQLResult<AccountEarningsQuery.Data>) -> [VaultUserData] {
        let vaultUserData = accountEarningsData.data?.accounts.flatMap { makeVaultUserData(forAccount: $0) } ?? []
        let allVaultAddresses = Set(vaultUserData.map { $0.vaultAddress.value })

        return allVaultAddresses.map { vaultAddress in
            let vaults = vaultUserData.filter { $0.vaultAddress.value == vaultAddress }
            return vaults.reduce(VaultUserData.empty) { result, vaultUserDatum in
                result.merged(withOtherVaultUserData: vaultUserDatum)
            }
        }
    }

    private static func makeVaultUserData(forAccount account: AccountEarningsQuery.Data.Account) -> [VaultUserData] {
        account.vaultPositions.compactMap { vaultPosition in
            guard let latestUpdate = vaultPosition.vault.latestUpdate,
                  let pricePerShare = BigUInt(latestUpdate.pricePerShare),
                  let balanceShares = BigUInt(vaultPosition.balanceShares) else {
                return nil
            }

            let currentBalance = balanceShares.multiplied(by: pricePerShare) / BigUInt(10).power(vaultPosition.token.decimals)

            let tokensSent = account.sharesSent
                .filter { $0.vault.id == vaultPosition.vault.id }
                .compactMap { BigUInt($0.tokenAmount) }
                .reduce(.zero, +)

            let tokensReceived = account.sharesReceived
                .filter { $0.vault.id == vaultPosition.vault.id }
                .compactMap { BigUInt($0.tokenAmount) }
                .reduce(.zero, +)

            let tokensDeposited = account.deposits
                .filter { $0.vault.id == vaultPosition.vault.id }
                .compactMap { BigUInt($0.tokenAmount) }
                .reduce(.zero, +)

            let tokensWithdrawn = account.withdrawals
                .filter { $0.vault.id == vaultPosition.vault.id }
                .compactMap { BigUInt($0.tokenAmount) }
                .reduce(.zero, +)

            let tokensIn = tokensReceived + tokensDeposited
            if tokensIn == .zero {
                // user hasn't ever bought any shares..
                // problem with the subgraph..
                return nil
            }

            let token = Token(
                address: Address(string: vaultPosition.token.id),
                symbol: vaultPosition.token.symbol,
                decimals: vaultPosition.token.decimals
            )

            let shareToken = Token(
                address: Address(string: vaultPosition.shareToken.id),
                symbol: vaultPosition.shareToken.symbol,
                decimals: vaultPosition.shareToken.decimals
            )

            return VaultUserData(
                vaultAddress: Address(string: vaultPosition.vault.id),
                currentBalance: currentBalance,
                tokensSent: tokensSent,
                tokensReceived: tokensReceived,
                tokensDeposited: tokensDeposited,
                tokensWithdrawn: tokensWithdrawn,
                token: token,
                shareToken: shareToken
            )
        }
    }
}

private extension VaultUserData {
    func merged(withOtherVaultUserData other: VaultUserData) -> VaultUserData {
        VaultUserData(
            vaultAddress: other.vaultAddress,
            currentBalance: currentBalance + other.currentBalance,
            tokensSent: tokensSent + other.tokensSent,
            tokensReceived: tokensReceived + other.tokensReceived,
            tokensDeposited: tokensDeposited + other.tokensDeposited,
            tokensWithdrawn: tokensWithdrawn + other.tokensWithdrawn,
            token: other.token,
            shareToken: other.shareToken
        )
    }

    static var empty = VaultUserData(
        vaultAddress: Address(string: ""),
        currentBalance: .zero,
        tokensSent: .zero,
        tokensReceived: .zero,
        tokensDeposited: .zero,
        tokensWithdrawn: .zero,
        token: Token(address: Address(string: ""), symbol: "", decimals: 0),
        shareToken: Token(address: Address(string: ""), symbol: "", decimals: 0)
    )
}
