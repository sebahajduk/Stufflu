//
//  MyProductsViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 26/04/2023.
//

import SwiftUI
import Combine

final class MyProductsViewModel: ObservableObject {

    var dataService: any CoreDataManager
    private var cancellables = Set<AnyCancellable>()

    @Published var myProducts = [ProductEntity]()
    @Published var searchText = ""
    @Published var showSellingAlert = false

    @Published var sortingType: SortingType = .addedDate

    @Published var isFilterActive = false
    @Published var minPrice = ""
    @Published var maxPrice = ""
    @Published var useImportance = false
    @Published var importance: Importance = .medium

    @Published var priceEnteredInAlert = ""

    @Published var productsValue: Double = .init()

    init(
        dataService: any CoreDataManager
    ) {
        self.dataService = dataService
        observeSearching()
        observeSorting()
        observeCoreData()
    }
}

extension MyProductsViewModel {
    func caredActionSwiped(_ product: ProductEntity) {
        ProductManager.cared(product)
    }

    func clearFilters() {
        isFilterActive = false
        minPrice = ""
        maxPrice = ""
        useImportance = false
        importance = .medium
    }

    func filter(
        _ completion: () -> Void
    ) {
        let filtered: [ProductEntity] = self.dataService.savedProductEntities.filter { $0.isSold == false }
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

    func sell(
        product: ProductEntity
    ) {
        if let price = Double(priceEnteredInAlert) {
            ProductManager.sell(product: product, for: price)
            dataService.refreshData()
            resetAlertValues()
        } else {
            ProductManager.sell(product: product, for: 0)
            dataService.refreshData()
            resetAlertValues()
        }
    }

    func use(
        product: ProductEntity
    ) {
        withAnimation {
            ProductManager.use(product: product)
            dataService.refreshData()
        }
    }
}

private extension MyProductsViewModel {
    func observeCoreData() {
        dataService.savedProductEntitiesPublisher
            .sink { [weak self] newValue in
                guard let self else { return }
                withAnimation {
                    self.myProducts = newValue.filter { $0.isSold == false }
                }
                productsValue = 0
                for product in myProducts {
                    productsValue += product.price
                }
            }
            .store(in: &cancellables)
    }

    func observeSearching() {
        $searchText
            .debounce(
                for: .milliseconds(200),
                scheduler: RunLoop.main
            )
            .sink { [weak self] searchText in
                guard let self else { return }

                withAnimation(.linear) {
                    if searchText.count > 0 {
                        self.myProducts = self.dataService.savedProductEntities.filter { $0.isSold == false }
                        let filteredProducts: [ProductEntity] = self.myProducts.filter {
                            guard let productName: String = $0.name else { return true }
                            return productName.lowercased().contains(searchText.lowercased())
                        }
                        self.myProducts = filteredProducts
                    } else {
                        self.myProducts = self.dataService.savedProductEntities.filter { $0.isSold == false }
                    }
                }
            }
            .store(in: &cancellables)
    }

    func observeSorting() {
        $sortingType
            .sink { [weak self] newType in
                guard let self else { return }
                withAnimation(.linear) {
                    self.myProducts = self.sortProducts(by: newType)
                }
            }
            .store(in: &cancellables)
    }

    func sortProducts(
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
            sortedArray = dataService.savedProductEntities.filter { $0.isSold == false }
        }

        return sortedArray
    }

    func resetAlertValues() {
        priceEnteredInAlert = ""
    }
}
