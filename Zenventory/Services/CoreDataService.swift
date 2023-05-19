//
//  CoreDataService.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import CoreData
import Combine

internal final class CoreDataService: ObservableObject, CoreDataManager {
    private var cancellable: Set<AnyCancellable> = .init()

    @Published internal var savedEntities: [ProductEntity] = .init()

    internal let container: NSPersistentContainer
    internal var savedEntitiesPublisher: Published<[ProductEntity]>.Publisher { $savedEntities }
    internal var savedEntitiesPublished: Published<[ProductEntity]> { _savedEntities }

    internal init() {
        container = NSPersistentContainer(name: "ProductsContainer")
        container.loadPersistentStores { (_, _) in }
        try? fetchProducts()
    }

    internal func fetchProducts() throws {
        let request: NSFetchRequest<ProductEntity> = .init(entityName: "ProductEntity")

        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            throw error
        }
    }

    internal func addProduct(
        name: String,
        guarantee: Int?,
        careName: String?,
        careInterval: Int?,
        price: Double?,
        importance: String
    ) {
        let newProduct: ProductEntity = .init(context: container.viewContext)

        newProduct.id = UUID()
        newProduct.name = name
        newProduct.careName = careName
        newProduct.importance = importance
        newProduct.lastUsed = Date()

        if let guarantee {
            newProduct.guarantee = Int16(guarantee)
        }

        if let careInterval {
            newProduct.careInterval = Int64(careInterval)
        }

        if let price {
            newProduct.price = price
        }

        try? saveData()
        try? fetchProducts()
    }

    internal func edit(
        product: ProductEntity
    ) {
        guard let index = savedEntities.firstIndex(where: { $0.id == product.id }) else { return }

        savedEntities.remove(at: index)

        savedEntities.insert(product, at: index)

        try? saveData()
        try? fetchProducts()
    }

    internal func removeProduct(
        at offsets: IndexSet
    ) {
        guard let index = offsets.first else { return }

        let entity: ProductEntity = savedEntities[index]

        container.viewContext.delete(entity)

        try? saveData()
        try? fetchProducts()
    }

    internal func saveData() throws {
        do {
            try container.viewContext.save()
        } catch {
            throw error
        }
    }
}
