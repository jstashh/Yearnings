//
//  UserAddressStore.swift
//  Yearnings
//

//

import Foundation
import Combine
import KeychainSwift

protocol UserAddressStoreProtocol {
    var addresses: [Address] { get set }
}

final class UserAddressStore: UserAddressStoreProtocol, ObservableObject {

    @Published var addresses: [Address] = []

    private static let addressesKeychainKey = "com.yearnings.address"
    private static let delimiter = ","
    private var cancellables = Set<AnyCancellable>()
    private lazy var keychain = KeychainSwift()


    init() {
        if let storedData = keychain.getData(Self.addressesKeychainKey), let combinedAddresses = String(data: storedData, encoding: .utf8) {
            addresses = combinedAddresses.components(separatedBy: Self.delimiter).map { Address(string: $0) }
        } else if let storedAddresses = UserDefaults.standard.array(forKey: Self.addressesKeychainKey) as? [String] {
            addresses = storedAddresses.map { Address(string: $0) }
            storeAddressesInKeychain(addresses)
            UserDefaults.standard.removeObject(forKey: Self.addressesKeychainKey)
        }

        $addresses
            .dropFirst()
            .sink { [weak self] addresses in
                self?.storeAddressesInKeychain(addresses)
            }
            .store(in: &cancellables)
    }

    private func storeAddressesInKeychain(_ addresses: [Address]) {
        let storedAddresses = addresses.map { $0.value }.joined(separator: Self.delimiter)
        if let data = storedAddresses.data(using: .utf8) {
            keychain.set(data, forKey: Self.addressesKeychainKey)
        }
    }
}
