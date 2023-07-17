//
//  CoreDataService.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import Foundation
import CoreData

internal protocol CoreDataManager: ObservableObject {

    var container: NSPersistentContainer { get set }
    var savedProductEntities: [ProductEntity] { get set }
    var savedProductEntitiesPublisher: Published<[ProductEntity]>.Publisher { get }

    var savedWishlistEntities: [WishlistEntity] { get set }
    var savedWishlistEntitiesPublisher: Published<[WishlistEntity]>.Publisher { get }

    func fetchProducts() throws
}

//MARK: Operations
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
}

// MARK: ProductEntity management
extension CoreDataManager {
    func addProduct(
        name: String,
        guarantee: Int?,
        careName: String?,
        careInterval: Int?,
        price: Double?,
        importance: String
    ) {
        let newProduct: ProductEntity = .init(context: container.viewContext)

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
    
    func edit(product: ProductEntity) {
        guard let index = savedProductEntities.firstIndex(where: { $0.id == product.id }) else { return }
        savedProductEntities[index] = product

        refreshData()
    }

    func addPhoto(product: ProductEntity) {
        guard let index = savedProductEntities.firstIndex(where: { $0.id == product.id }) else { return }

        let entity: ProductEntity = savedProductEntities[index]

        entity.productPhotoPath = nil
        entity.productPhotoPath = "\(entity.id ?? UUID())"

        refreshData()
    }
    func deletePhoto(product: ProductEntity) {
        guard let index = savedProductEntities.firstIndex(where: { $0.id == product.id }) else { return }

        let entity: ProductEntity = savedProductEntities[index]

        if let _ = entity.productPhotoPath {
            entity.productPhotoPath = nil
        }

        refreshData()
    }
    func addInvoicePhoto(product: ProductEntity) {
        guard let index = savedProductEntities.firstIndex(where: { $0.id == product.id }) else { return }

        let entity: ProductEntity = savedProductEntities[index]

        entity.productInvoicePath = "\(entity.id ?? UUID())Invoice"

        refreshData()
    }
}

// MARK: WishlistEntity management
extension CoreDataManager {
    func addWishlistProduct(
        days: Date,
        link: String?,
        name: String,
        price: Double?
    ) { }
}
