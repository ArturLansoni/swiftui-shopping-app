//
//  DoubleExtension.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 31/01/24.
//

import Foundation

extension Double {
    func toString() -> String {
        "\(self)"
    }
    
    func formatToCurrency(locale: Locale = Locale.current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
