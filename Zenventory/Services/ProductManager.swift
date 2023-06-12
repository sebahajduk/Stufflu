//
//  ProductManager.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 12/06/2023.
//

import Foundation

internal struct ProductManager {

    static func use(product: ProductEntity) {
        product.lastUsed = Date()
    }

}
