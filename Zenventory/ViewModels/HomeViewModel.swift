//
//  HomeViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import Combine
import UIKit

class HomeViewModel: ObservableObject {
    @Published internal var products: [ProductEntity] = []

    internal var dataService: any CoreDataManager

    private var cancellables = Set<AnyCancellable>()

    internal init(
        dataService: any CoreDataManager
    ) {
        self.dataService = dataService
        showSavedProducts()
        observeEntity()
    }

    private func showSavedProducts() {
        products = dataService.savedEntities
    }

    private func observeEntity() {
        dataService.savedEntitiesPublisher
            .sink { [weak self] newValue in
                guard let self else { return }
                self.products = newValue
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
