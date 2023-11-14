//
//  CoreDataService.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import CoreData

final class CoreDataService: ObservableObject, CoreDataManager {
    @Published var savedProductEntities = [ProductEntity]()
    @Published var savedWishlistEntities = [WishlistEntity]()

    var container: NSPersistentContainer

    var savedWishlistEntitiesPublisher: Published<[WishlistEntity]>.Publisher { $savedWishlistEntities }
    var savedProductEntitiesPublisher: Published<[ProductEntity]>.Publisher { $savedProductEntities }

    init() {
        container = NSPersistentContainer(name: "ProductsContainer")
        container.loadPersistentStores { (_, _) in }

        try? fetchProducts()
    }
}
