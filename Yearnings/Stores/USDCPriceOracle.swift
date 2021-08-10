//
//  USDPriceOracle.swift
//  Yearnings
//

//

import Foundation
import Web3
import Web3ContractABI
import Combine

protocol USDCPriceOracleProtocol {
    func fetchPrice(forTokenAddress tokenAddress: Address, shareTokenAddress: Address) -> AnyPublisher<BigUInt, Error>
}

final class USDCPriceOracle: USDCPriceOracleProtocol {

    private lazy var oracleAddress = try! EthereumAddress(hex: Externals.usdPriceOracleAddress, eip55: true)
    private lazy var backupOracleAddress = try! EthereumAddress(hex: Externals.backupUsdPriceOracleAddress, eip55: true)
    private let ethPriceStore: EthPriceStoreProtocol
    private let web3Store: Web3StoreProtocol

    init(ethPriceStore: EthPriceStoreProtocol, web3Store: Web3StoreProtocol) {
        self.ethPriceStore = ethPriceStore
        self.web3Store = web3Store
    }

    func fetchPrice(forTokenAddress tokenAddress: Address, shareTokenAddress: Address) -> AnyPublisher<BigUInt, Error> {
        let future = Future<BigUInt, Error> { promise in
            do {
                let web3TokenAddress = try EthereumAddress(hex: tokenAddress.value, eip55: false)
                let contract = try self.web3Store.web3.eth.Contract(json: Data.oracleContractAbi, abiKey: nil, address: self.oracleAddress)

                contract["getPriceUsdcRecommended"]!([web3TokenAddress]).call { dict, error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        guard let usdcPrice = dict?[""] as? BigUInt, usdcPrice != .zero else {
                            self.fetchPriceUsingBackupOracle(shareTokenAddress: shareTokenAddress, promise: promise)
                            return
                        }

                        promise(.success(usdcPrice))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }
        .flatMap { tokenPriceUsd -> AnyPublisher<BigUInt, Never> in
            if tokenPriceUsd == .zero, Externals.ethEquivalentVaultAddresses.contains(tokenAddress.value) {
                // these tokens are problematic, often returning a price of 0. Assume the value is approximately the same as Eth
                return self.ethPriceStore.ethPrice()
            } else {
                return Just(tokenPriceUsd).eraseToAnyPublisher()
            }
        }
        return AnyPublisher(future.receive(on: DispatchQueue.main))
    }

    func fetchPriceUsingBackupOracle(shareTokenAddress: Address, promise: @escaping (Result<BigUInt, Error>) -> Void) {
        do {
            let web3TokenAddress = try EthereumAddress(hex: shareTokenAddress.value, eip55: false)
            let contract = try self.web3Store.web3.eth.Contract(json: Data.backupOracleContractAbi, abiKey: nil, address: self.backupOracleAddress)

            contract["assetsTvlBreakdown"]!([web3TokenAddress]).call { dict, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    // ignore the next line please 🤮
                    let usdcPrice = ((((dict![""]! as! [Any])[0] as! [Any])[2]) as! BigUInt)
                    promise(.success(usdcPrice))
                }
            }
        } catch {
            promise(.failure(error))
        }
    }
}
