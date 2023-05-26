//
//  WishlistProductCellViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 20/05/2023.
//

import Foundation

class WishlistProductCellViewModel: ObservableObject {

    @Published internal var product: ProductEntity

    init(product: ProductEntity) {
        self.product = product
    }

}
