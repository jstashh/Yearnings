//
//  VaultPositionHistoricEarningsViewModel.swift
//  Yearnings
//
//

import Foundation
import BigInt

final class VaultPositionHistoricEarningsViewModel {

    let vaultPositionUpdates: [AccountVaultPositionUpdate]
    let shareTokenDecimals: Int
    let vaultHistoricalUpdates: [VaultHistoricalUpdates]
    private lazy var historicalEarningsTracker = HistoricalEarningsTracker(
        vaultPositionUpdates: vaultPositionUpdates,
        shareTokenDecimals: shareTokenDecimals
    )

    init(vaultPositionUpdates: [AccountVaultPositionUpdate], shareTokenDecimals: Int, vaultHistoricalUpdates: [VaultHistoricalUpdates]) {
        self.vaultPositionUpdates = vaultPositionUpdates
        self.shareTokenDecimals = shareTokenDecimals
        self.vaultHistoricalUpdates = vaultHistoricalUpdates
    }

    var data: [(String, Double)] {
        vaultHistoricalUpdates.map { vaultUpdate in
            self.historicalEarningsTracker.earnings(forDate: vaultUpdate.date, pricePerShare: vaultUpdate.pricePerShare)
        }
    }
}

private final class HistoricalEarningsTracker {

    struct Snapshot {
        let deposits: BigInt
        let withdrawals: BigInt
        let tokensReceived: BigInt
        let tokensSent: BigInt
        let balanceShares: BigInt
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter
    }()

    let snapshotTimeline: [(dates: Range<Date>, snapshot: Snapshot)]
    let shareTokenDecimals: Int

    init(vaultPositionUpdates: [AccountVaultPositionUpdate], shareTokenDecimals: Int) {
        self.shareTokenDecimals = shareTokenDecimals
        guard !vaultPositionUpdates.isEmpty else {
            snapshotTimeline = []
            return
        }

        var result: [(dates: Range<Date>, snapshot: Snapshot)] = []

        for (index, update) in vaultPositionUpdates.enumerated() where vaultPositionUpdates.count > 1 {
            if index == 0 {
                let range = Date.distantPast ..< update.timeStamp
                let snapshot = Snapshot(
                    deposits: update.deposits,
                    withdrawals: update.withdrawals,
                    tokensReceived: update.tokensReceived,
                    tokensSent: update.tokensSent,
                    balanceShares: update.balanceShares
                )
                result.append((range, snapshot))
            } else {
                let previousUpdate = vaultPositionUpdates[index - 1]
                let previousSnapshot = result[index - 1]
                let range = previousUpdate.timeStamp ..< update.timeStamp

                let snapshot = Snapshot(
                    deposits: update.deposits + previousSnapshot.snapshot.deposits,
                    withdrawals: update.withdrawals + previousSnapshot.snapshot.withdrawals,
                    tokensReceived: update.tokensReceived + previousSnapshot.snapshot.tokensReceived,
                    tokensSent: update.tokensSent + previousSnapshot.snapshot.tokensSent,
                    balanceShares: update.balanceShares
                )
                result.append((range, snapshot))
            }
        }
        if let lastUpdate = vaultPositionUpdates.last {
            let range = lastUpdate.timeStamp ..< Date.distantFuture
            if let lastSnapshot = result.last {
                result.append((range, lastSnapshot.snapshot))
            } else {
                let snapshot = Snapshot(
                    deposits: lastUpdate.deposits,
                    withdrawals: lastUpdate.withdrawals,
                    tokensReceived: lastUpdate.tokensReceived,
                    tokensSent: lastUpdate.tokensSent,
                    balanceShares: lastUpdate.balanceShares
                )
                result.append((range, snapshot))
            }
        }
        snapshotTimeline = result
    }

    func earnings(forDate date: Date, pricePerShare: BigInt) -> (String, Double) {
        guard let snapshot = snapshotTimeline.first(where: {
            $0.dates.contains(date)
        }).map({ $0.snapshot }) else {
            return ("", .zero)
        }

        let balanceTokens = snapshot.balanceShares * pricePerShare / BigInt(10).power(shareTokenDecimals)
        let positives = balanceTokens + snapshot.withdrawals + snapshot.tokensSent
        let negatives = snapshot.deposits + snapshot.tokensReceived
        let earnings = positives - negatives
        let dateString = Self.dateFormatter.string(from: date)
        return (dateString, earnings.doubleValue(tokenDecimals: shareTokenDecimals))
    }

}
