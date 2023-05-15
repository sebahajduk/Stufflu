//
//  String+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 17/04/2023.
//

import Foundation

extension String {

    private struct NumFormatter {
        static let instance: NumberFormatter = .init()
    }

    internal var isDouble: Bool {
        return NumFormatter.instance.number(from: self)?.doubleValue != nil
    }

    internal var isInteger: Bool {
        let digitsCharacters: CharacterSet = .init(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}
