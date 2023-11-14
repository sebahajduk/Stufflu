//
//  ProductManager.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 12/06/2023.
//

import Foundation

struct ProductManager {

    static func use(product: ProductEntity) {
        product.lastUsed = Date()
    }

    static func cared(_ product: ProductEntity) {
        product.lastCared = Date()
    }

    static func sell(
        product: ProductEntity,
        for price: Double
    ) {
        product.isSold = true
        product.soldDate = Date()
        product.soldPrice = price

        try? ZFileManager.deleteImage(name: product.productPhotoPath ?? "")
        try? ZFileManager.deleteImage(name: product.productInvoicePath ?? "")
    }
}
