//
//  NumberFormatter+Swool.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import Foundation

extension NumberFormatter {

    static var rounded: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.roundingMode = .halfUp
        return formatter
    }
}

extension Float {

    var rounded: String {
        return NumberFormatter.rounded.string(from: NSNumber(value: self)) ?? description
    }
}

extension Double {

    var rounded: String {
        return NumberFormatter.rounded.string(from: NSNumber(value: self)) ?? description
    }
}
