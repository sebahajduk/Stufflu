//
//  ProductDetailsVM.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI

class ProductDetailsVM: ObservableObject {

    @Published var product: ProductEntity
    @Published var image: UIImage?

    init(product: ProductEntity) {
        self.product = product
        self.image = ZFileManager.instance.getImage(name: product.name!)
    }

    

}
