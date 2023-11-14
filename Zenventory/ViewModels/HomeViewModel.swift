//
//  HomeViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/04/2023.
//

import Foundation
import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {

    var dataService: any CoreDataManager
    private var cancellables = Set<AnyCancellable>()

    @Published var products = [ProductEntity]()
    @Published var boughtSummary: Double = .init()
    @Published var soldSummary: Double = .init()
    @Published var listIsEmpty = true

    init(
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
                self.products = newValue.filter {
                    ($0.lastUsed ?? Date()).distance(to: Date()) > 2_592_000 &&
                    $0.isSold == false
                }

                if products.count == 0 {
                    listIsEmpty = true
                } else {
                    listIsEmpty = false
                }

                prepareBoughtSummary(for: newValue)
                prepareSoldSummary(for: newValue)
            }
            .store(in: &cancellables)
    }

    func use(
        product: ProductEntity
    ) {
        withAnimation {
            ProductManager.use(product: product)
            dataService.refreshData()
        }
    }

    private func prepareBoughtSummary(
        for entities: [ProductEntity]
    ) {
        let boughtProducts = entities.filter {
            ($0.soldDate ?? Date()).distance(to: Date()) < 2_592_000 &&
            $0.isSold == false
        }
        self.boughtSummary = 0

        for product in boughtProducts {
            self.boughtSummary += product.price
        }
    }

    private func prepareSoldSummary (
        for entities: [ProductEntity]
    ) {
        let soldProducts = entities.filter {
            ($0.soldDate ?? Date()).distance(to: Date()) < 2_592_000 &&
            $0.isSold == true
        }

        self.soldSummary = 0

        for product in soldProducts {
            soldSummary += product.soldPrice
        }
    }
}
