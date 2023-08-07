//
//  WishlistProductCellViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 27/07/2023.
//

import Foundation

final class WishlistProductCellViewModel: ObservableObject {

    @Published internal var product: WishlistEntity
    @Published internal var daysLeft: String = .init()

    private var productDaysLeft: DateComponents?

    init(for product: WishlistEntity) {
        self.product = product

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
        self.daysLeft = "\(daysCounter)"
    }

}
