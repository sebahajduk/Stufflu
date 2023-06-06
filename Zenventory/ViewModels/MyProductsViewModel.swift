//
//  MyProductsViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 26/04/2023.
//

import SwiftUI
import Combine

internal final class MyProductsViewModel: ObservableObject {

    unowned internal var dataService: any CoreDataManager
    private var cancellables = Set<AnyCancellable>()

    @Published internal var myProducts: [ProductEntity] = .init()
    @Published internal var searchText: String = .init()

    //MARK: Sorting
    @Published internal var sortingType: SortingType = .addedDate

    //MARK: --- Filtering params ---
    @Published internal var isFilterActive: Bool = false
    @Published internal var minPrice: String = .init()
    @Published internal var maxPrice: String = .init()
    @Published internal var useImportance = false
    @Published internal var importance: Importance = .medium

    internal init(
        dataService: any CoreDataManager
    ) {
        self.dataService = dataService
        loadMyItems()
        observeSearching()
        observeSorting()

        observeCoreData()
    }

    private func loadMyItems() {
        myProducts = dataService.savedEntities
    }

    // MARK: Listening for changes in CoreData

    private func observeCoreData() {
        dataService.savedEntitiesPublisher
            .sink { [weak self] newValue in
                guard let self else { return }
                self.myProducts = newValue
            }
            .store(in: &cancellables)
    }

    // MARK: User actions handlers

    private func observeSearching() {
        $searchText
            .debounce(
                for: .milliseconds(200),
                scheduler: RunLoop.main
            )
            .sink { [weak self] searchText in
                guard let self else { return }

                withAnimation(.linear) {
                    if searchText.count > 0 {
                        let filteredProducts: [ProductEntity] = self.myProducts.filter {
                            guard let productName: String = $0.name else { return true }
                            return productName.lowercased().contains(searchText.lowercased())
                        }
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

    private func sortProducts(
        by type: SortingType
    ) -> [ProductEntity] {
        var sortedArray: [ProductEntity] = .init()

        switch type {
        case .lowestPrice:
            sortedArray = self.myProducts.sorted { $0.price < $1.price }
        case .highestPrice:
            sortedArray = self.myProducts.sorted { $0.price > $1.price }
        case .nameAZ:
            sortedArray = self.myProducts.sorted { $0.name ?? "Unknown" < $1.name ?? "Unknown" }
        case .nameZA:
            sortedArray = self.myProducts.sorted { $0.name ?? "Unknown" > $1.name ?? "Unknown" }
        case .lastUsed:
            sortedArray = self.myProducts.sorted { $0.lastUsed ?? Date() < $1.lastUsed ?? Date() }
        case .addedDate:
            sortedArray = dataService.savedEntities
        }

        return sortedArray
    }

    internal func clearFilters() {
        isFilterActive = false
        minPrice = ""
        maxPrice = ""
        useImportance = false
        importance = .medium
    }

    internal func filter(
        _ completion: () -> ()
    ) {
        let filtered: [ProductEntity] = self.dataService.savedEntities
            .filter { (entity) -> Bool in
                guard minPrice.count > 0 else { return true }
                return entity.price >= Double(minPrice) ?? 0
            }
            .filter { (entity) -> Bool in
                guard maxPrice.count > 0 else { return true }
                return entity.price <= Double(maxPrice) ?? 0
            }
            .filter { (entity) -> Bool in
                guard
                    useImportance,
                    let entityImportance: String = entity.importance
                else { return true }

                return entityImportance.lowercased() == importance.rawValue.lowercased()
            }

        withAnimation {
            myProducts = filtered
        }
        completion()
    }
}
