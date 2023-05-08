//
//  ProductCellViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 20/04/2023.
//

import SwiftUI

class ProductCellViewModel: ObservableObject {

    @Published var product: ProductEntity
    @Published var lastUsed: String
    @Published var productImage: UIImage?

    init(product: ProductEntity) {
        self.product = product
        lastUsed = product.lastUsed?.formatted(date: .numeric, time: .omitted) ?? "Unknown"
        productImage = ZFileManager.getImage(name: product.name ?? "Unknown")
    }

    
}
