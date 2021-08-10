//
//  NumberFormatters.swift
//  Yearnings
//

//

import Foundation

extension NumberFormatter {
    static let usdFormatter: NumberFormatter = {
        let formatter = KNumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        return formatter
    }()

    static let ethFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Ξ"
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 3
        formatter.minimumIntegerDigits = 1
        return formatter
    }()

    static let nativeFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 4
        formatter.minimumIntegerDigits = 1
        return formatter
    }()

    static let percentageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        return formatter
    }()
}

extension NumberFormatter {
    func string(from double: Double) -> String {
        self.string(from: double as NSNumber) ?? ""
    }
}

private class KNumberFormatter : NumberFormatter {
    override func string(for obj: Any?) -> String? {
        guard let num = obj as? NSNumber else {
            return nil
        }
        let suffixes = ["", "K", "M", "B"]
        var idx = 0
        var d = num.doubleValue
        while idx < 3 && abs(d) >= 1000.0 {
            d /= 1000.0
            idx += 1
        }
        var currencyCode = ""
        if let currencySymbol = self.currencySymbol {
            currencyCode = currencySymbol
        }

        let numStr = String(format: "%.\(maximumFractionDigits)f", d)

        return currencyCode + numStr + suffixes[idx]
    }
}
