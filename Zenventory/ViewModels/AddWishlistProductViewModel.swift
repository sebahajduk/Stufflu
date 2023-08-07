//
//  AddWishlistProductViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/07/2023.
//

import Foundation

final class AddWishlistProductViewModel: ObservableObject {

    @Published internal var dataService: any CoreDataManager

    init(dataService: any CoreDataManager) {
        self.dataService = dataService
    }

    internal func addWishlistProduct(
        days: String,
        link: String?,
        name: String,
        price: String
    ) {
        /// days - Date
        /// link - String
        /// name: String
        /// price: Double

        var dateComponent = DateComponents()
        dateComponent.day = Int(days)
        let finalDate = Calendar.current.date(byAdding: dateComponent, to: Date())

        let productPrice = Double(price)

        dataService.addWishlistProduct(days: finalDate!, link: link, name: name, price: productPrice)
    }
}
