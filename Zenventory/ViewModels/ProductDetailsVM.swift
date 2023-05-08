//
//  ProductDetailsVM.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI

class ProductDetailsVM: ObservableObject {

    @Published internal var product: ProductEntity
    @Published internal var image: UIImage?

    internal init(
        product: ProductEntity
    ) {
        self.product = product
        self.image = ZFileManager.getImage(name: product.name!)
    }
}
