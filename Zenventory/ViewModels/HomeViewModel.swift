//
//  HomeViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    var dataService: CoreDataService

    @Published var products: [ProductEntity] = []

    private var cancellables = Set<AnyCancellable>()

    init(dataService: CoreDataService) {
        self.dataService = dataService
        showSavedProducts()
        observeEntity()
    }

    private func showSavedProducts() {
        products = dataService.savedEntities
    }

    private func observeEntity() {
        dataService.$savedEntities
            .sink { [weak self] newValue in
                guard let self else { return }
                self.products = newValue
            }
            .store(in: &cancellables)
    }

    func deleteItem(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)
    }
}
