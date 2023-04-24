//
//  ProductCellViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 20/04/2023.
//

import Foundation

class ProductCellViewModel: ObservableObject {

    @Published var product: ProductEntity
    @Published var lastUsed: String

    init(product: ProductEntity) {
        self.product = product
        lastUsed = product.lastUsed?.formatted(date: .numeric, time: .omitted) ?? "Unknown"
    }

    
}
