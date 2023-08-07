//
//  Double+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/06/2023.
//

import Foundation

extension Double {
    func asPrice() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency

        return formatter.string(from: self as NSNumber) ?? ""
    }
}
