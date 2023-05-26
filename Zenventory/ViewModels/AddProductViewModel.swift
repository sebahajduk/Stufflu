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

    internal var dataService: CoreDataService

    internal init(
        dataService: CoreDataService
    ) {
        self.dataService = dataService
        runObservers()
    }

    private var cancellables: Set<AnyCancellable> = .init()

    @Published internal var selectedProductPhoto: PhotosPickerItem?
    @Published internal var selectedInvoicePhoto: PhotosPickerItem?
    @Published internal var selectedImportance: Importance = .medium

    // MARK: --- Product details ---
    @Published internal var productName: String = .init()
    @Published internal var productImage: UIImage?
    @Published internal var invoiceImage: UIImage?
    @Published internal var productGuarantee: String = .init()
    @Published internal var productImportance: Int = .init()
    @Published internal var productCareName: String = .init()
    @Published internal var productCareInterval: String = .init()
    @Published internal var productPrice: String = .init()

    // MARK: --- Textfields validation ---
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

        let productID: UUID = dataService.savedEntities.last?.id ?? UUID()

        if let productImage: UIImage = productImage {
            try? ZFileManager.saveImage(
                productImage: productImage,
                name: "\(productID)"
            )
        }

        if let invoiceImage: UIImage = invoiceImage {
            try? ZFileManager.saveImage(
                productImage: invoiceImage,
                name: "\(productID)Invoice")
        }
    }

    private func textfieldsAreValid() -> Bool {
        nameIsValid && guaranteeIsValid && careNameIsValid && careIntervalIsValid && priceIsValid
    }

    private func runObservers() {
        observeSelectedItem()
        observeNameTF()
        observeGuarantee()
        observeCareName()
        observeCareInterval()
        observePrice()
    }

    private func observeSelectedItem() {
        $selectedProductPhoto
            .compactMap { $0 }
            .tryAwaitMap { index in
                /// Needs to be converted into Data because type Image.self does not show photos other than .png
                /// for example .heic or .jpeg
                return try await index.loadTransferable(type: Data.self) ?? Data()
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                guard let self else { return }
                if let image: UIImage = .init(data: value) {
                    self.productImage = image
                }
            }
            .store(in: &cancellables)
    }

    private func observeNameTF() {
        $productName
            .map { $0.count >= 3 }
            .assign(to: \.nameIsValid, on: self)
            .store(in: &cancellables)
    }

    private func observeGuarantee() {
        $productGuarantee
            .map { $0.isInteger || $0.count == 0 }
            .assign(to: \.guaranteeIsValid, on: self)
            .store(in: &cancellables)
    }

    private func observeCareName() {
        $productCareName
            .map { $0.count >= 3 || $0.count == 0 }
            .assign(to: \.careNameIsValid, on: self)
            .store(in: &cancellables)
    }

    private func observeCareInterval() {
        $productCareInterval
            .map { $0.isInteger || $0.count == 0 }
            .assign(to: \.careIntervalIsValid, on: self)
            .store(in: &cancellables)
    }

    private func observePrice() {
        $productPrice
            .map { $0.isDouble || $0.count == 0 }
            .assign(to: \.priceIsValid, on: self)
            .store(in: &cancellables)
    }
}





