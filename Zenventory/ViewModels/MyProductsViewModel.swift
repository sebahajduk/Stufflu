//
//  MyProductsViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 26/04/2023.
//

import Foundation
import SwiftUI
import Combine

class MyProductViewModel: ObservableObject {

    var dataService: CoreDataService

    @Published var myProducts: [ProductEntity] = []
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()

    init(dataService: CoreDataService) {
        self.dataService = dataService
        loadMyItems()
        observeSearching()
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

}
