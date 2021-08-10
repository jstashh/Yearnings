//
//  BigUInt+Double.swift
//  Yearnings
//

//

import Foundation
import BigInt

extension BigUInt {
    func doubleValue(tokenDecimals decimals: Int) -> Double {
        let divisor = BigUInt(10).power(decimals)
        let (quotient, remainder) = self.quotientAndRemainder(dividingBy: divisor)
        var remainderStr = remainder.description
        if remainder.description.count < decimals {
            let numberOfZerosToPadWith = decimals - remainder.description.count
            remainderStr = String(repeating: "0", count: numberOfZerosToPadWith) + remainderStr
        }
        let decimalString = "\(quotient.description).\(remainderStr)"
        return Double(decimalString) ?? .zero
    }
}

extension BigInt {
    func doubleValue(tokenDecimals decimals: Int) -> Double {
        let divisor = BigInt(10).power(decimals)
        let (quotient, remainder) = self.quotientAndRemainder(dividingBy: divisor)
        var remainderStr = remainder.description
        if remainder.description.count < decimals {
            let numberOfZerosToPadWith = decimals - remainder.description.count
            remainderStr = String(repeating: "0", count: numberOfZerosToPadWith) + remainderStr
        }
        let decimalString = "\(quotient.description).\(remainderStr)"
        return Double(decimalString) ?? .zero
    }
}
