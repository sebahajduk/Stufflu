//
//  String+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 17/04/2023.
//

import Foundation

extension String {
    struct NumFormatter {
        static let instance = NumberFormatter()
    }

    var isDouble: Bool {
        return NumFormatter.instance.number(from: self)?.doubleValue != nil
    }

    var isInteger: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}
