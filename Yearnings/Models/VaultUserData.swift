//
//  VaultUserData.swift
//  Yearnings
//

//

import Foundation
import BigInt

struct VaultUserData {
    let vaultAddress: Address
    let currentBalance: BigUInt
    let tokensSent: BigUInt
    let tokensReceived: BigUInt
    let tokensDeposited: BigUInt
    let tokensWithdrawn: BigUInt
    let token: Token
    let shareToken: Token
}
