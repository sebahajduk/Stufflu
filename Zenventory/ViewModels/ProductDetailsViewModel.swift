//
//  ProductDetailsVM.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI

internal final class ProductDetailsViewModel: ObservableObject {

    @Published internal var product: ProductEntity
    @Published internal var image: UIImage?

    internal init(
        product: ProductEntity
    ) {
        self.product = product
        image = try? ZFileManager.getImage(name: product.name ?? "Unknown")
    }
}
