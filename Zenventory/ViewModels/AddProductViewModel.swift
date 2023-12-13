//
//  AddProductVModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI
import Combine
import PhotosUI

final class AddProductViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private var dataService: any CoreDataManager

    @Published var selectedImportance: Importance = .medium

    // MARK: Product details
    @Published var productName: String = .init()
    @Published var productImage: UIImage?
    @Published var invoiceImage: UIImage?
    @Published var productGuarantee: String = .init()
    @Published var productCareName: String = .init()
    @Published var productCareInterval: String = .init()
    @Published var productPrice: String = .init()

    // MARK: Textfields validation
    @Published var nameIsValid: Bool = false
    @Published var guaranteeIsValid: Bool = true
    @Published var careNameIsValid: Bool = true
    @Published var careIntervalIsValid: Bool = true
    @Published var priceIsValid: Bool = true

    @Published var addButtonIsEnabled: Bool = false

    init(
        dataService: CoreDataService
    ) {
        self.dataService = dataService
        runObservers()
    }

    func addButtonTapped() {
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

    private func updateAddButtonIsEnabled() {
        addButtonIsEnabled = nameIsValid && guaranteeIsValid && careNameIsValid && careIntervalIsValid && priceIsValid
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
                    self.updateAddButtonIsEnabled()
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
                    self.updateAddButtonIsEnabled()
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
                    self.updateAddButtonIsEnabled()
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
                    self.updateAddButtonIsEnabled()
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
                    self.updateAddButtonIsEnabled()
                }
            }
            .store(in: &cancellables)
    }
}
