//
//  SortingType.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 10/05/2023.
//

import Foundation

enum SortingType: String, CaseIterable, Identifiable {
    var id: Self { self }
    case lowestPrice = "Price lowest",
         highestPrice = "Price highest",
         nameAZ = "Name A-Z",
         nameZA = "Name Z-A",
         lastUsed = "Last used",
         addedDate = "Added date"
}
