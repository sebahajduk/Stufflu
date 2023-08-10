//
//  WishlistViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 17/07/2023.
//

import SwiftUI
import Combine

class WishlistViewModel: ObservableObject {

    unowned internal var dataService: any CoreDataManager

    @Published internal var wishlistProducts: [WishlistEntity] = .init()
    @Published internal var searchText: String = .init()

    private var cancellables: Set<AnyCancellable> = .init()

    internal init(dataService: any CoreDataManager) {
        self.dataService = dataService
        observeWishlistProducts()
        observeSearchText()
    }

    internal func deleteWishlistProduct(at offsets: IndexSet) {
        wishlistProducts.remove(atOffsets: offsets)
        dataService.removeWishlistProduct(at: offsets)
    }
}

// MARK: Combine
extension WishlistViewModel {

    private func observeWishlistProducts() {
        dataService.savedWishlistEntitiesPublisher
            .sink { [weak self] newValue in
                self?.wishlistProducts = newValue
            }
            .store(in: &cancellables)
    }

    private func observeSearchText() {
        $searchText
            .debounce(
                for: .milliseconds(200),
                scheduler: RunLoop.main
            )
            .sink { [weak self] searchText in
                guard let self else { return }
                withAnimation(.linear) {
                    if searchText.count > 0 {
                        self.wishlistProducts = self.dataService.savedWishlistEntities
                        let filteredProducts: [WishlistEntity] = self.wishlistProducts.filter {
                            guard let productName: String = $0.name else { return true }
                            return productName.lowercased().contains(searchText.lowercased())
                        }
                        self.wishlistProducts = filteredProducts
                    } else {
                        self.wishlistProducts = self.dataService.savedWishlistEntities
                    }
                }
            }
            .store(in: &cancellables)
    }
}
