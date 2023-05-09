//
//  CoreDataService.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import Combine
import CoreData

internal class CoreDataService: ObservableObject, CoreDataManager {
    @Published internal var savedEntities: [ProductEntity] = []

    internal let container: NSPersistentContainer
    internal var savedEntitiesPublisher: Published<[ProductEntity]>.Publisher { $savedEntities }
    internal var savedEntitiesPublished: Published<[ProductEntity]> { _savedEntities }

    private var cancellables = Set<AnyCancellable>()

    internal init() {
        container = NSPersistentContainer(name: "ProductsContainer")
        container.loadPersistentStores { (_, _) in }
        try? fetchProducts()
    }

    internal func fetchProducts() throws {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")

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
        let newProduct = ProductEntity(context: container.viewContext)

        newProduct.id = UUID()
        newProduct.name = name
        newProduct.careName = careName
        newProduct.importance = importance
        newProduct.lastUsed = Date()

        if guarantee != nil {
            newProduct.guarantee = Int16(guarantee!)
        }

        if careInterval != nil {
            newProduct.careInterval = Int64(careInterval!)
        }

        if price != nil {
            newProduct.price = price!
        }
        try? saveData()
        try? fetchProducts()
    }

    internal func removeProduct(
        at offsets: IndexSet
    ) {
        guard let index = offsets.first else { return }

        let entity = savedEntities[index]
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
