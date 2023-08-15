//
//  AddWishlistProductViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/07/2023.
//

import SwiftUI
import Combine

final class AddWishlistProductViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = .init()

    unowned internal var dataService: any CoreDataManager

    @Published internal var nameTextField: String = .init()
    @Published internal var nameIsValid: Bool = false

    @Published internal var daysCounterTextField: String = .init()
    @Published internal var daysCounterIsValid: Bool = false

    @Published internal var linkTextField: String = .init()
    @Published internal var linkIsValid: Bool = true

    @Published internal var priceTextField: String = .init()
    @Published internal var priceIsValid: Bool = true

    init(dataService: any CoreDataManager) {
        self.dataService = dataService
        textFieldsValidation()
    }

    private func textFieldsValidation() {
        observeNameTextField()
        observeDaysCounterTextField()
        observeLinkTextField()
        observePriceTextField()
    }

    private func observeNameTextField() {
        $nameTextField
            .sink { [weak self] name in
                guard let self else { return }
                withAnimation {
                    self.nameIsValid = name.count >= 3

                }
            }
            .store(in: &cancellables)
    }

    private func observeDaysCounterTextField() {
        $daysCounterTextField
            .sink { [weak self] days in
                guard let self else { return }
                withAnimation {
                    self.daysCounterIsValid = days.isInteger
                }
            }
            .store(in: &cancellables)
    }

    private func observeLinkTextField() {
        $linkTextField
            .sink { [weak self] link in
                guard let self else { return }
                withAnimation {
                    self.linkIsValid = link.count > 3 || link.isEmpty
                }
            }
            .store(in: &cancellables)
    }

    private func observePriceTextField() {
        $priceTextField
            .sink { [weak self] price in
                guard let self else { return }
                withAnimation {
                    self.priceIsValid = price.isDouble || price.isEmpty
                }
            }
            .store(in: &cancellables)
    }

    internal func addWishlistProduct(
        days: String,
        link: String?,
        name: String,
        price: String,
        completion: @escaping (Bool) -> Void
    ) {
        /// days - Date
        /// link - String
        /// name: String
        /// price: Double

        var dateComponent = DateComponents()
        dateComponent.day = Int(days)

        guard let finalDate = Calendar.current.date(byAdding: dateComponent, to: Date()) else {
            completion(false)
            return
        }

        guard nameIsValid && daysCounterIsValid && linkIsValid && priceIsValid else {
            completion(false)
            return
        }

        let productPrice = Double(price)

        dataService.addWishlistProduct(days: finalDate, link: link, name: name, price: productPrice)
        completion(true)
    }
}
