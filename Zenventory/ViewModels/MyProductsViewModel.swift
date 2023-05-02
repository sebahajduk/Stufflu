//
//  MyProductsViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 26/04/2023.
//

import Foundation
import SwiftUI
import Combine

enum SortingType: String, CaseIterable, Identifiable {
    var id: Self { self }
    case lowPrice = "Price lowest",
         hightPrice = "Price highest",
         nameAZ = "Name A-Z",
         nameZA = "Name Z-A",
         lastUsed = "Last used",
         addedDate = "Added date"
}

class MyProductViewModel: ObservableObject {

    var dataService: CoreDataService
    private var cancellables = Set<AnyCancellable>()

    @Published var myProducts: [ProductEntity] = []
    @Published var searchText: String = ""
    @Published var sortingType: SortingType = .addedDate

    init(dataService: CoreDataService) {
        self.dataService = dataService
        loadMyItems()
        observeSearching()
        observeSorting()
    }

    private func loadMyItems() {
        myProducts = dataService.savedEntities
    }

    private func observeSearching() {
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                guard let self else { return }

                withAnimation(.linear) {
                    if searchText.count > 0 {
                        let filteredProducts = self.myProducts.filter { $0.name!.lowercased().contains(searchText.lowercased())}
                        self.myProducts = filteredProducts
                    } else {
                        self.myProducts = self.dataService.savedEntities
                    }
                }
            }
            .store(in: &cancellables)
    }

    private func observeSorting() {
        $sortingType
            .sink { [weak self] newType in
                guard let self else { return }
                withAnimation(.linear) {
                    self.myProducts = self.sortProducts(by: newType)

                }
            }
            .store(in: &cancellables)
    }

    private func sortProducts(by type: SortingType) -> [ProductEntity] {
        var sortedArray: [ProductEntity] = []

        switch type {
        case .lowPrice:
            sortedArray = self.myProducts.sorted { $0.price < $1.price }
        case .hightPrice:
            sortedArray = self.myProducts.sorted { $0.price > $1.price }
        case .nameAZ:
            sortedArray = self.myProducts.sorted { $0.name! < $1.name! }
        case .nameZA:
            sortedArray = self.myProducts.sorted { $0.name! > $1.name! }
        case .lastUsed:
            sortedArray = self.myProducts.sorted { $0.lastUsed ?? Date() < $1.lastUsed ?? Date() }
        case .addedDate:
            sortedArray = dataService.savedEntities
        }

        return sortedArray
    }

}
