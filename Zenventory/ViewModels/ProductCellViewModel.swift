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

    @Published internal var urls: Set<URL> = ZFileManager.urls

    internal init(
        product: ProductEntity
    ) {
        self.product = product
        lastUsed = product.lastUsed?.formatted(date: .numeric, time: .omitted) ?? "Unknown"
        productImage = try? ZFileManager.getImage(name: "\(product.id ?? UUID())")

        observeProductChanges()
    }

    private func observeProductChanges() {
        ZFileManager.urls.publisher
            .sink { _ in
                print("I have new photo!")
            }
            .store(in: &cancellables)
    }

}
