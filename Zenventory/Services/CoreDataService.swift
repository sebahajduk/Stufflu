//
//  CoreDataService.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import CoreData

internal final class CoreDataService: ObservableObject, CoreDataManager {
    @Published internal var savedWishlistEntities: [WishlistEntity] = .init()

    var savedWishlistEntitiesPublisher: Published<[WishlistEntity]>.Publisher { $savedWishlistEntities }
    

    @Published internal var savedProductEntities: [ProductEntity] = .init()
    
    internal var container: NSPersistentContainer
    internal var savedProductEntitiesPublisher: Published<[ProductEntity]>.Publisher { $savedProductEntities }

    internal init() {
        container = NSPersistentContainer(name: "ProductsContainer")
        container.loadPersistentStores { (_, _) in }
        try? fetchProducts()
    }

    internal func fetchProducts() throws {
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
