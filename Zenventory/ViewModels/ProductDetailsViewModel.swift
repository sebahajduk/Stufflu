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

    @Published internal var isEditing: Bool = false

    internal init(
        product: ProductEntity
    ) {
        self.product = product
        image = try? ZFileManager.getImage(name: product.name ?? "Unknown")
    }

    internal func editButtonTapped() {
        withAnimation {
            isEditing = true
        }
    }

    internal func saveButtonTapped() {
        withAnimation {
            isEditing = false
        }
    }

    internal func cancelButtonTapped() {
        withAnimation {
            isEditing = false
        }
    }

    // MARK: Product GETTERS

    internal func getCareInterval() -> String {
        product.careInterval != 0 ? String(product.careInterval) : "-"
    }

    internal func getCareName() -> String {
        if let careName = product.careName {
            return careName
        } else {
            return "-"
        }
    }

    internal func getFavorite() -> Bool {
        product.favorite
    }

    internal func getGuarantee() -> String {
        product.guarantee != 0 ? String(product.guarantee) : "-"
    }

    internal func getImportance() -> String {
        if let importance = product.importance {
            return importance
        } else {
            return "-"
        }
    }

    internal func getLastCared() -> String {
        product.lastCared?.asString() ?? "-"
    }

    internal func getLastUsed() -> String {
        product.lastCared?.asString() ?? "-"
    }

    internal func getName() -> String {
        product.name ?? "Unknown"
    }

    internal func getPrice() -> String {
        product.price != 0 ? String(product.price) : "-"
    }

    internal func getDescription() -> String {
        product.productDescr ?? "-"
    }

}
