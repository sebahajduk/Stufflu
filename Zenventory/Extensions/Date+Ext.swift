//
//  Date+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 15/05/2023.
//

import Foundation

extension Date {
    internal func asString() -> String {
        let formatter: DateFormatter = .init()
        return formatter.string(from: self)
    }
}
