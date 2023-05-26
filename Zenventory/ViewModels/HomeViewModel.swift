//
//  HomeViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import Combine
import UIKit

internal final class HomeViewModel: ObservableObject {

    @Published internal var products: [ProductEntity] = .init()

    internal var dataService: any CoreDataManager

    private var cancellables: Set<AnyCancellable> = .init()

    internal init(
        dataService: any CoreDataManager
    ) {
        self.dataService = dataService
        showSavedProducts()
        observeEntity()
    }

    func showSavedProducts() {
        products = dataService.savedEntities
    }

    private func observeEntity() {
        dataService.savedEntitiesPublisher
            .sink { [weak self] newValue in
                if let self {
                    self.objectWillChange.send()
                    self.showSavedProducts()
                }
            }
            .store(in: &cancellables)
    }

    internal func deleteItem(
        at offsets: IndexSet
    ) {
        products.remove(atOffsets: offsets)
        dataService.removeProduct(at: offsets)
    }
}
