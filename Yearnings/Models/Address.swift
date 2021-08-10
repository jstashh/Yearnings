//
//  Address.swift
//  Yearnings
//

//

import Foundation
import CryptoSwift

struct Address {
    let value: String

    init(string: String) {
        self.value = string
    }

    var checksummed: String {
        let address = value.lowercased().replacingOccurrences(of: "0x", with: "")
        let addressHash = address.sha3(.keccak256)
        var checksumAddress = "0x"

        for index in address.indices {
            let hashedCharacter = String(addressHash[index])
            if UInt8(hashedCharacter, radix: 16)! > 7 {
                checksumAddress.append(address[index].uppercased())
            } else {
                checksumAddress.append(address[index])
            }
        }

        return checksumAddress
    }
}

extension Address {
    static let empty = Address(string: "")
}
