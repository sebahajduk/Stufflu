//
//  HistoryViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 01/08/2023.
//

import SwiftUI
import Combine

final class HistoryViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    private var dataService: any CoreDataManager

    @Published var historyPickerSelection: HistoryOptions = .all
    @Published var shownProducts = [ProductEntity]()

    init(dataService: any CoreDataManager) {
        self.dataService = dataService
        updatingShownProducts()
    }

    private func updatingShownProducts() {
        $historyPickerSelection
            .sink { [weak self] selection in
                guard let self else { return }

                switch selection {
                case .all:
                    showAllProducts()
                case .bought:
                    showBoughtProducts()
                case .sold:
                    showSoldProducts()
                }
            }
            .store(in: &cancellables)
    }

    func getDate(for product: ProductEntity) -> String {
        if product.isSold {
            return product.soldDate?.asString() ?? ""
        } else {
            return product.addedDate?.asString() ?? ""
        }
    }

    private func sortProducts(
        in array: [ProductEntity]
    ) -> [ProductEntity] {

        var sortedArray = array

        sortedArray.sort { product, nextProduct in
            guard let previousAddedDate = product.addedDate,
                  let nextAddedDate = nextProduct.addedDate
            else { return false }

            let dateOne = (product.soldDate ?? previousAddedDate)
            let dateTwo = (nextProduct.soldDate ?? nextAddedDate)

            return dateOne.compare(dateTwo) == .orderedDescending
        }

        return sortedArray
    }

    private func showSoldProducts() {
        var filteredArray = dataService.savedProductEntities.filter { $0.isSold == true }
        filteredArray.sort {
            guard let previousAddedDate = $0.addedDate,
                  let nextAddedData = $1.addedDate
            else { return false }
            return $0.soldDate ?? previousAddedDate > $1.soldDate ?? nextAddedData
        }

        let sortedArray = sortProducts(in: filteredArray)

        self.shownProducts = sortedArray
    }

    private func showBoughtProducts() {
        var filteredArray = dataService.savedProductEntities.filter { $0.isSold == false }
        filteredArray.sort {
            guard let previousAddedDate = $0.addedDate,
                  let nextAddedData = $1.addedDate
            else { return false }

            return $0.soldDate ?? previousAddedDate > $1.soldDate ?? nextAddedData
        }

        let sortedArray = sortProducts(in: filteredArray)

        self.shownProducts = sortedArray
    }

    private func showAllProducts() {
        let sortedArray = sortProducts(in: dataService.savedProductEntities)
        self.shownProducts = sortedArray
    }
}
