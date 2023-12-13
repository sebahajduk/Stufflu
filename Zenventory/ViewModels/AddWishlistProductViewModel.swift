//
//  AddWishlistProductViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/07/2023.
//

import SwiftUI
import Combine

final class AddWishlistProductViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    private var dataService: any CoreDataManager

    @Published var nameTextField = ""
    @Published var nameIsValid = false

    @Published var daysCounterTextField = ""
    @Published var daysCounterIsValid = false

    @Published var linkTextField = ""
    @Published var linkIsValid = true

    @Published var priceTextField = ""
    @Published var priceIsValid = true

    @Published var isAddButtonEnabled = false

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

    private func updateIsAddButtonEnabled() {
        isAddButtonEnabled = nameIsValid && daysCounterIsValid && linkIsValid && priceIsValid
    }

    private func observeNameTextField() {
        $nameTextField
            .sink { [weak self] name in
                guard let self else { return }
                withAnimation {
                    self.nameIsValid = name.count >= 3
                    self.updateIsAddButtonEnabled()
                }
            }
            .store(in: &cancellables)
    }

    private func observeDaysCounterTextField() {
        $daysCounterTextField
            .sink { [weak self] days in
                guard let self else { return }
                withAnimation {
                    self.daysCounterIsValid = days.isInteger && days.count != 0
                    self.updateIsAddButtonEnabled()
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
                    self.updateIsAddButtonEnabled()
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
                    self.updateIsAddButtonEnabled()
                }
            }
            .store(in: &cancellables)
    }

    func addWishlistProduct(
        days: String,
        link: String?,
        name: String,
        price: String,
        completion: @escaping (Bool) -> Void
    ) {
        var dateComponent = DateComponents()
        dateComponent.day = Int(days)

        guard
            let finalDate = Calendar.current.date(byAdding: dateComponent, to: Date()),
            nameIsValid && daysCounterIsValid && linkIsValid && priceIsValid
        else {
            completion(false)
            return
        }

        let productPrice = Double(price)

        dataService.addWishlistProduct(days: finalDate, link: link, name: name, price: productPrice)
        completion(true)
    }
}
