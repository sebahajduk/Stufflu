//
//  ProductCellViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 20/04/2023.
//

import SwiftUI
import Combine

internal final class ProductCellViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = .init()

    @Published internal var product: ProductEntity
    @Published internal var lastUsed: String
    @Published internal var productImage: UIImage?

    internal init(
        product: ProductEntity
    ) {
        self.product = product
        lastUsed = product.lastUsed?.formatted(date: .numeric, time: .omitted) ?? "Unknown"
        productImage = try? ZFileManager.getImage(name: product.productPhotoPath ?? "Unknown")

        observeProductChanges()
        
    }

    private func observeProductChanges() {
        $product
            .sink { newValue in
                self.productImage = try? ZFileManager.getImage(name: newValue.productPhotoPath ?? "Unknown")
            }
            .store(in: &cancellables)
    }

}
