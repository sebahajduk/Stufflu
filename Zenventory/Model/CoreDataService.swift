//
//  CoreDataService.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import Combine
import CoreData

class CoreDataService: ObservableObject {

    let container: NSPersistentContainer
    @Published var savedEntities: [ProductEntity] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        container = NSPersistentContainer(name: "ProductsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data: \(error.localizedDescription)")
            }
        }
        fetchProducts()

    }

    func fetchProducts() {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")

        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }

    func addProduct(name: String,
                    guarantee: Int?,
                    careName: String?,
                    careInterval: Int?,
                    price: Double?,
                    importance: Int) {

        let newProduct = ProductEntity(context: container.viewContext)

        newProduct.name = name

        if guarantee != nil {
            newProduct.guarantee = Int16(guarantee!)
        }
        newProduct.careName = careName

        if careInterval != nil {
            newProduct.careInterval = Int64(careInterval!)
        }
        if price != nil {
            newProduct.price = price!
        }

        newProduct.importance = Int64(importance)

        saveData()
    }

    private func saveData() {
        do {
            try container.viewContext.save()
            fetchProducts()
            print(savedEntities)
        } catch {
            print("Error\(error.localizedDescription)")
        }
    }
}
