//
//  WishlistProductCellViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 27/07/2023.
//

import Foundation

final class WishlistProductCellViewModel: ObservableObject {

    @Published var product: WishlistEntity
    @Published var daysLeft = ""
    @Published var productHasValidURL = false

    private var productDaysLeft: DateComponents?

    init(for product: WishlistEntity) {
        self.product = product

        productDaysToDecisionValidation()
        productLinkValidation()
    }
}

private extension WishlistProductCellViewModel {
    func productDaysToDecisionValidation() {
        guard let deadline = product.daysCounter else {
            self.daysLeft = "No data"
            return
        }

        self.productDaysLeft = Calendar.current.dateComponents(
            [.day],
            from: Date(),
            to: deadline
        )

        guard let daysCounter = productDaysLeft?.day else { return }
        self.daysLeft = daysCounter < 0 ? "0" : "\(daysCounter)"
    }

    func productLinkValidation() {
        guard let link = self.product.link else { return }
        self.productHasValidURL = link.isValidURL
    }
}
