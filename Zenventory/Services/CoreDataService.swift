//
//  CoreDataService.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import CoreData

internal final class CoreDataService: ObservableObject, CoreDataManager {
    @Published internal var savedProductEntities: [ProductEntity] = .init()
    @Published internal var savedWishlistEntities: [WishlistEntity] = .init()
    
    internal var container: NSPersistentContainer
    
    internal var savedWishlistEntitiesPublisher: Published<[WishlistEntity]>.Publisher { $savedWishlistEntities }
    internal var savedProductEntitiesPublisher: Published<[ProductEntity]>.Publisher { $savedProductEntities }
    
    internal init() {
        container = NSPersistentContainer(name: "ProductsContainer")
        container.loadPersistentStores { (_, _) in }
        try? fetchProducts()
    }
}
