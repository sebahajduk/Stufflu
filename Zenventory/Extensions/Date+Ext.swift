//
//  Date+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 15/05/2023.
//

import Foundation

extension Date {
    func asString() -> String {
        return self.formatted(date: .numeric, time: .omitted)
    }

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
