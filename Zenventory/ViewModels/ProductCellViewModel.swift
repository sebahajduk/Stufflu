//
//  ProductCellViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 20/04/2023.
//

import SwiftUI

internal final class ProductCellViewModel: ObservableObject {

    @Published internal var product: ProductEntity
    @Published internal var lastUsed: String
    @Published internal var productImage: UIImage?

    internal init(
        product: ProductEntity
    ) {
        self.product = product
        lastUsed = product.lastUsed?.formatted(date: .numeric, time: .omitted) ?? "Unknown"
        productImage = try? ZFileManager.getImage(name: product.name ?? "Unknown")
    }
}
