//
//  HomeViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import Combine
import SwiftUI

internal final class HomeViewModel: ObservableObject {

    @Published internal var products: [ProductEntity] = .init()
    @Published internal var selectedProduct: ProductEntity? = nil
    @Published internal var boughtSummary: Double = .init()
    @Published internal var soldSummary: Double = .init()
    @Published internal var listIsEmpty: Bool = true

    unowned internal var dataService: any CoreDataManager

    private var cancellables: Set<AnyCancellable> = .init()

    internal init(
        dataService: any CoreDataManager
    ) {
        self.dataService = dataService
        observeEntity()
    }

    private func observeEntity() {
        dataService.savedProductEntitiesPublisher
            .sink { [weak self] newValue in
                guard let self else { return }
                // 2_592_000 = 30 days
                self.products = newValue.filter { ($0.lastUsed ?? Date()).distance(to: Date()) > 2_592_000 && $0.isSold == false}
                let soldProducts = newValue.filter { $0.isSold == true && ($0.soldDate ?? Date()).distance(to: Date()) < 2_592_000 }
                self.boughtSummary = 0
                self.soldSummary = 0

                if products.count == 0 {
                    listIsEmpty = true
                } else {
                    listIsEmpty = false
                }

                for product in products {
                    boughtSummary += product.price
                }

                for product in soldProducts {
                    soldSummary += product.soldPrice
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

    internal func use(
        product: ProductEntity
    ) {
        withAnimation {
            ProductManager.use(product: product)
            dataService.refreshData()
        }
    }
}
