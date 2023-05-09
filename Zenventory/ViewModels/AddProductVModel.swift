//
//  AddProductVModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI
import Combine
import PhotosUI

enum Importance: String, CaseIterable, Identifiable {
    case low, medium, high
    var id: Self { self }
}

final internal class AddProductVModel: ObservableObject {

    internal var dataService: CoreDataService

    internal init(
        dataService: CoreDataService
    ) {
        self.dataService = dataService
        runObservers()
    }

    private var cancellables = Set<AnyCancellable>()

    @Published internal var selectedProductPhoto: PhotosPickerItem?
    @Published internal var selectedInvoicePhoto: PhotosPickerItem?
    @Published internal var selectedImportance: Importance = .medium

    // MARK: --- Product details ---
    @Published internal var productName: String = ""
    @Published internal var productImage: UIImage?
    @Published internal var invoiceImage: UIImage?
    @Published internal var productGuarantee: String = ""
    @Published internal var productImportance: Int = 0
    @Published internal var productCareName: String = ""
    @Published internal var productCareInterval: String = ""
    @Published internal var productPrice: String = ""
    @Published internal var importanceSlider: Double = 5

    // MARK: --- Textfields validation ---
    @Published internal var nameIsValid = false
    @Published internal var guaranteeIsValid = true
    @Published internal var careNameIsValid = true
    @Published internal var careIntervalIsValid = true
    @Published internal var priceIsValid = true

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


        if let productImage = productImage {
            try? ZFileManager.saveImage(productImage: productImage, name: productName)
        }

        if let invoiceImage = invoiceImage {
            try? ZFileManager.saveImage(productImage: invoiceImage, name: "\(productName)Invoice")
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
            .sink { value in
                if let image = UIImage(data: value) {
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





