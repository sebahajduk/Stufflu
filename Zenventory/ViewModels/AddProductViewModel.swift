//
//  AddProductVModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI
import Combine
import PhotosUI

internal final class AddProductViewModel: ObservableObject {

    unowned internal var dataService: CoreDataService

    internal init(
        dataService: CoreDataService
    ) {
        self.dataService = dataService
        runObservers()
    }

    private var cancellables: Set<AnyCancellable> = .init()

    @Published internal var selectedImportance: Importance = .medium

    // MARK: Product details
    @Published internal var productName: String = .init()
    @Published internal var productImage: UIImage?
    @Published internal var invoiceImage: UIImage?
    @Published internal var productGuarantee: String = .init()
    @Published internal var productCareName: String = .init()
    @Published internal var productCareInterval: String = .init()
    @Published internal var productPrice: String = .init()

    // MARK: Textfields validation
    @Published internal var nameIsValid: Bool = false
    @Published internal var guaranteeIsValid: Bool = true
    @Published internal var careNameIsValid: Bool = true
    @Published internal var careIntervalIsValid: Bool = true
    @Published internal var priceIsValid: Bool = true

    internal func addButtonTapped() {
        guard textfieldsAreValid() else { return }

        dataService.addProduct(
            name: productName,
            guarantee: Int(productGuarantee) ?? nil,
            careName: productCareName,
            careInterval: Int(productCareInterval) ?? nil,
            price: Double(productPrice) ?? nil,
            importance: selectedImportance.rawValue
        )

        guard let product = dataService.savedProductEntities.last else { return }

        let productID: UUID = product.id ?? UUID()

        if let productImage: UIImage = productImage {
            try? ZFileManager.saveImage(
                productImage: productImage,
                name: "\(productID)"
            )
            dataService.addPhoto(product: product)
        }

        if let invoiceImage: UIImage = invoiceImage {
            try? ZFileManager.saveImage(
                productImage: invoiceImage,
                name: "\(productID)Invoice"
            )
            dataService.addInvoicePhoto(product: product)
        }
    }

    private func textfieldsAreValid() -> Bool {
        nameIsValid && guaranteeIsValid && careNameIsValid && careIntervalIsValid && priceIsValid
    }

    private func runObservers() {
        observeNameTF()
        observeGuarantee()
        observeCareName()
        observeCareInterval()
        observePrice()
    }

    private func observeNameTF() {
        $productName
            .map { $0.count >= 3 }
            .sink { [weak self] bool in
                guard let self else { return }
                withAnimation {
                    self.nameIsValid = bool
                }
            }
            .store(in: &cancellables)
    }

    private func observeGuarantee() {
        $productGuarantee
            .map { $0.isInteger || $0.count == 0 }
            .sink { [weak self] bool in
                guard let self else { return }
                withAnimation {
                    self.guaranteeIsValid = bool
                }
            }
            .store(in: &cancellables)
    }

    private func observeCareName() {
        $productCareName
            .map { $0.count >= 3 || $0.count == 0 }
            .sink { [weak self] bool in
                guard let self else { return }
                withAnimation {
                    self.careNameIsValid = bool
                }
            }
            .store(in: &cancellables)
    }

    private func observeCareInterval() {
        $productCareInterval
            .map { $0.isInteger || $0.count == 0 }
            .sink { [weak self] bool in
                guard let self else { return }
                withAnimation {
                    self.careIntervalIsValid = bool
                }
            }
            .store(in: &cancellables)
    }

    private func observePrice() {
        $productPrice
            .map { $0.isDouble || $0.count == 0 }
            .sink { [weak self] bool in
                guard let self else { return }
                withAnimation {
                    self.priceIsValid = bool
                }
            }
            .store(in: &cancellables)
    }
}
