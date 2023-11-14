//
//  Importance.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 10/05/2023.
//

import Foundation

enum Importance: String, CaseIterable, Identifiable {
    var id: Self { self }
    case low, medium, high
}
