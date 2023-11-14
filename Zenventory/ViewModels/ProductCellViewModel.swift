//
//  ProductCellViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 20/04/2023.
//

import SwiftUI
import Combine

final class ProductCellViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    @Published var product: ProductEntity
    @Published var lastUsed: String
    @Published var productImage: UIImage?

    init(
        product: ProductEntity
    ) {
        self.product = product
        lastUsed = product.lastUsed?.formatted(date: .numeric, time: .omitted) ?? "Unknown"

        productImage = try? ZFileManager.getImage(
            name: product.productPhotoPath ?? "Unknown"
        )

        observeProductChanges()
    }

    private func observeProductChanges() {
        $product
            .sink { [weak self] newValue in
                guard let self else { return }
                self.productImage = try? ZFileManager.getImage(
                    name: newValue.productPhotoPath ?? "Unknown"
                )
            }
            .store(in: &cancellables)
    }
}
