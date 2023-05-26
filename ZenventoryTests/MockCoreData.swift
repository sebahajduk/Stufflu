//
//  MockCoreData.swift
//  ZenventoryTests
//
//  Created by Sebastian Hajduk on 02/05/2023.
//

import Foundation
import CoreData
import Combine
@testable import Zenventory

class MockCoreData: NSObject, CoreDataManager {

    var container: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(filePath: "/dev/null")

        let container = NSPersistentContainer(name: "ProductsContainer")

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError(error.localizedDescription)
            }
        }

        return container
    }()

    @Published var savedEntities: [ProductEntity] = []
    var savedEntitiesPublisher: Published<[Zenventory.ProductEntity]>.Publisher { $savedEntities }

    func removeProduct(at offsets: IndexSet) {
        if let index = offsets.first {
            let entity: ProductEntity = savedEntities[index]

            container.viewContext.delete(entity)

            try? saveData()
            try? fetchProducts()
        }
    }

    func edit(product: Zenventory.ProductEntity) {
        
    }

    func fetchProducts() throws {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")

        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            throw error
        }
    }

    func addProduct(name: String,
                    guarantee: Int?,
                    careName: String?,
                    careInterval: Int?,
                    price: Double?,
                    importance: String) {

        let newProduct = ProductEntity(context: container.viewContext)

        newProduct.id = UUID()
        newProduct.name = name
        newProduct.careName = careName
        newProduct.importance = importance
        newProduct.lastUsed = Date()

        if let guarantee{
            newProduct.guarantee = Int16(guarantee)
        }
        if let careInterval {
            newProduct.careInterval = Int64(careInterval)
        }
        if let price {
            newProduct.price = price
        }

        try? saveData()
    }

    func saveData() throws {
        do {
            try container.viewContext.save()
        } catch {
            throw error
        }
    }

}
