//
//  Double+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/06/2023.
//

import SwiftUI

extension Double {
    func asPrice() -> String {
        @AppStorage("currency") var currency = "localCurrency"

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        if currency == "localCurrency" {
            guard let locale = NSLocale.current.currency else { return "" }
            currency = locale.identifier
        }

        let locale = NSLocale(localeIdentifier: currency)
        formatter.currencySymbol = locale.displayName(forKey: .currencySymbol, value: currency)
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
