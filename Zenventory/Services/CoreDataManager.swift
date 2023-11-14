//
//  CoreDataService.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import Foundation
import CoreData

protocol CoreDataManager: ObservableObject {
    var container: NSPersistentContainer { get set }
    var savedProductEntities: [ProductEntity] { get set }
    var savedProductEntitiesPublisher: Published<[ProductEntity]>.Publisher { get }

    var savedWishlistEntities: [WishlistEntity] { get set }
    var savedWishlistEntitiesPublisher: Published<[WishlistEntity]>.Publisher { get }

    func fetchProducts() throws
}

extension CoreDataManager {
    func saveData() throws {
        do {
            try container.viewContext.save()
        } catch {
            throw error
        }
    }

    func removeProduct(at offsets: IndexSet) {
        guard let index = offsets.first else { return }

        let entity: ProductEntity = savedProductEntities[index]

        container.viewContext.delete(entity)

        refreshData()
    }

    func refreshData() {
        try? saveData()
        try? fetchProducts()
    }

    func fetchProducts() throws {
        let productRequest: NSFetchRequest<ProductEntity> = .init(entityName: "ProductEntity")
        let wishlistRequest: NSFetchRequest<WishlistEntity> = .init(entityName: "WishlistEntity")
        do {
            savedProductEntities = try container.viewContext.fetch(productRequest)
            savedWishlistEntities = try container.viewContext.fetch(wishlistRequest)
        } catch {
            throw error
        }
    }
}

// MARK: ProductEntity management
extension CoreDataManager {
    // swiftlint: disable function_parameter_count
    func addProduct(
        name: String,
        guarantee: Int?,
        careName: String?,
        careInterval: Int?,
        price: Double?,
        importance: String
    ) {
        let newProduct = ProductEntity(context: container.viewContext)

        newProduct.id = UUID()
        newProduct.addedDate = Date()
        newProduct.name = name
        newProduct.careName = careName
        newProduct.importance = importance
        newProduct.lastUsed = Calendar.current.date(byAdding: .day, value: -3, to: Date())

        if let guarantee {
            newProduct.guarantee = Int16(guarantee)
        }

        if let careInterval {
            newProduct.careInterval = Int64(careInterval)
        }

        if let price {
            newProduct.price = price
        }

        refreshData()
    }
    // swiftlint: enable function_parameter_count

    func edit(product: ProductEntity) {
        if let index = getIndex(for: product) {
            savedProductEntities[index] = product
            refreshData()
        }
    }

    func addPhoto(product: ProductEntity) {
        if let index = getIndex(for: product) {
            let entity: ProductEntity = savedProductEntities[index]

            entity.productPhotoPath = nil
            entity.productPhotoPath = "\(entity.id ?? UUID())"

            refreshData()
        }
    }

    func deletePhoto(product: ProductEntity) {
        if let index = getIndex(for: product) {
            let entity: ProductEntity = savedProductEntities[index]
            if entity.productPhotoPath != nil {
                entity.productPhotoPath = nil
                refreshData()
            }
        }
    }
    func addInvoicePhoto(product: ProductEntity) {
        if let index = getIndex(for: product) {
            let entity: ProductEntity = savedProductEntities[index]
            entity.productInvoicePath = "\(entity.id ?? UUID())Invoice"

            refreshData()
        }
    }
}

private extension CoreDataManager {
    func getIndex(for product: ProductEntity) -> Int? {
        guard
            let index = savedProductEntities.firstIndex(where: { $0.id == product.id })
        else { return nil }

        return index
    }
}

// MARK: WishlistEntity management
extension CoreDataManager {
    func addWishlistProduct(
        days: Date,
        link: String?,
        name: String,
        price: Double?
    ) {
        let newWishlistProduct: WishlistEntity = .init(context: container.viewContext)

        newWishlistProduct.id = UUID()
        newWishlistProduct.daysCounter = days
        newWishlistProduct.name = name

        if let link {
            newWishlistProduct.link = link
        } else {
            newWishlistProduct.link = ""
        }

        if let price {
            newWishlistProduct.price = price
        } else {
            newWishlistProduct.price = 0
        }

        refreshData()
    }

    func removeWishlistProduct(at offsets: IndexSet) {
        guard let index = offsets.first else { return }

        let entity: WishlistEntity = savedWishlistEntities[index]

        container.viewContext.delete(entity)

        refreshData()
    }

    func editWishlistProduct(product: WishlistEntity) {
        guard let index = savedWishlistEntities.firstIndex(where: { $0.id == product.id }) else { return }
        savedWishlistEntities[index] = product

        refreshData()
    }
}
