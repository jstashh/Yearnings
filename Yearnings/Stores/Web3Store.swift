//
//  Web3.swift
//  Yearnings
//

//

import Foundation
import Web3

protocol Web3StoreProtocol {
    var web3: Web3 { get }
}

final class Web3Store: Web3StoreProtocol {
    let web3 = Web3(rpcURL: Externals.infuraRpcURL)
}
