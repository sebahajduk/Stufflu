//
//  Importance.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 10/05/2023.
//

import Foundation

internal enum Importance: String, CaseIterable, Identifiable {
    internal var id: Self { self }
    case low, medium, high
}
