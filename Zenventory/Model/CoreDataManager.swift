//
//  CoreDataService.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import Foundation
import CoreData

protocol CoreDataManager: ObservableObject {
    var container: NSPersistentContainer { get }
    var savedEntities: [ProductEntity] { get }
    var savedEntitiesPublisher: Published<[ProductEntity]>.Publisher { get }
    
    func saveData()
    func removeProduct(at offsets: IndexSet)
    func fetchProducts()
    func addProduct(name: String,
                    guarantee: Int?,
                    careName: String?,
                    careInterval: Int?,
                    price: Double?,
                    importance: String)
}
