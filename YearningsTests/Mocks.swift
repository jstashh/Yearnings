//
//  Mocks.swift
//  YearningsTests
//

//

import Foundation
import Combine
import UIKit
import BigInt

@testable import Yearnings

struct MockImageStore: ImageStoreProtocol {
    func loadImage(fromUrl url: URL) -> AnyPublisher<UIImage, Never> {
        Just(UIImage()).eraseToAnyPublisher()
    }
}

struct MockVaultAliasStore: VaultAliasStoreProtocol {
    func getAlias(forTokenWithAddress: Address) -> AnyPublisher<String?, Never> {
        Just(nil).eraseToAnyPublisher()
    }
}

struct MockUSDCPriceOracle: USDCPriceOracleProtocol {
    func fetchPrice(forTokenAddress tokenAddress: Address) -> AnyPublisher<BigUInt, Error> {
        Just(.zero)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
