//
//  ProductDetailsVM.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI
import Combine
import PhotosUI

final class ProductDetailsViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    private var dataService: any CoreDataManager

    @Published var product: ProductEntity
    @Published var image: UIImage?
    @Published var invoiceImage: UIImage?

    @Published var isEditing: Bool = false

    /// TextFields binders
    @Published var productLastUsed = ""
    @Published var productName = ""
    @Published var productCareName = ""
    @Published var productCareInterval = ""
    @Published var productLastCared = ""
    @Published var productGuarantee = ""
    @Published var productPrice = ""
    @Published var productDescription = ""

    /// TextFields inputs check
    @Published var productCareNameIsValid = true
    @Published var productNameIsValid = true
    @Published var productLastUsedIsValid = true
    @Published var productCareIntervalIsValid = true
    @Published var productLastCaredIsValid = true
    @Published var productGuaranteeIsValid = true
    @Published var productPriceIsValid = true

    /// Photo picker binding
    @Published var photosPickerItem: PhotosPickerItem?

    @Published var sellPrice: String = ""

    init(
        product: ProductEntity,
        dataService: any CoreDataManager
    ) {
        self.product = product
        self.dataService = dataService

        self.productName = product.name ?? "Unknown"
        image = try? ZFileManager.getImage(
            name: product.productPhotoPath ?? "Unknown"
        )
        invoiceImage = try? ZFileManager.getImage(
            name: product.productInvoicePath ?? "Unknown"
        )

        productDescription = product.productDescr ?? ""

        if let lastUsed = product.lastUsed {
            self.productLastUsed = "\(lastUsed.formatted(date: .numeric, time: .omitted))"
        }

        if let lastCared = product.lastCared {
            self.productLastCared = "\(lastCared.formatted(date: .numeric, time: .omitted))"
        }

        runObservers()
    }
}

extension ProductDetailsViewModel {
    func sellProduct() {
        var price: Double = 0.0

        if !sellPrice.isEmpty && sellPrice.isDouble {
            price = Double(sellPrice) ?? 0.0
        }

        ProductManager.sell(product: product, for: price)
        dataService.refreshData()
    }
    func deletePhoto() {
        try? ZFileManager.deleteImage(
            name: product.productPhotoPath ?? "Unknown"
        )

        dataService.deletePhoto(product: product)
        self.image = nil
    }

    func editButtonTapped() {
        withAnimation {
            isEditing = true
        }
    }

    func saveButtonTapped() {
        if dataIsValid() {
            product.name = productName
            product.productDescr = productDescription

            if productCareName.count > 3 {
                product.careName = productCareName
            }
            if productCareInterval.count >= 1 {
                product.careInterval = Int64(productCareInterval) ?? 0
            }
            if productGuarantee.count >= 1 {
                product.guarantee = Int16(productGuarantee) ?? 0
            }
            if productPrice.count >= 1 {
                product.price = Double(productPrice) ?? 0.0
            }

            dataService.edit(product: product)
        }

        withAnimation {
            isEditing = false
        }
    }

    func cancelButtonTapped() {
        withAnimation {
            isEditing = false
        }
    }

    func getCareInterval() -> String {
        product.careInterval != 0 ? String(product.careInterval) : "-"
    }

    func getCareName() -> String {
        if let careName = product.careName {
            return careName
        } else {
            return "-"
        }
    }

    func getGuarantee() -> String {
        product.guarantee != 0 ? String(product.guarantee) : "-"
    }

    func getName() -> String {
        product.name ?? "Unknown"
    }

    func getPrice() -> String {
        product.price.asPrice()
    }

    func getDescription() -> String {
        product.productDescr ?? ""
    }
}

private extension ProductDetailsViewModel {
    func dataIsValid() -> Bool {
        productCareNameIsValid &&
        productNameIsValid &&
        productCareIntervalIsValid &&
        productGuaranteeIsValid &&
        productPriceIsValid
    }

    func runObservers() {
        observeCareNameTextField()
        observeNameTextField()
        observeCareIntervalTextField()
        observeGuaranteeTextField()
        observePriceTextField()
        observeImageChanges()
        observeProduct()
    }

    func observeCareNameTextField() {
        $productCareName
            .map { $0.count == 0 || $0.count >= 3 }
            .sink { [weak self] value in
                guard let self else { return }
                self.productCareNameIsValid = value
            }
            .store(in: &cancellables)
    }

    func observeNameTextField() {
        $productName
            .map { $0.count >= 3 }
            .sink { [weak self] value in
                guard let self else { return }
                self.productNameIsValid = value
            }
            .store(in: &cancellables)
    }

    func observeCareIntervalTextField() {
        $productCareInterval
            .map { $0.isInteger }
            .sink { [weak self] value in
                guard let self else { return }
                self.productCareIntervalIsValid = value
            }
            .store(in: &cancellables)
    }

    func observeGuaranteeTextField() {
        $productGuarantee
            .map { $0.isInteger }
            .sink { [weak self] value in
                guard let self else { return }
                self.productGuaranteeIsValid = value
            }
            .store(in: &cancellables)
    }

    func observePriceTextField() {
        $productPrice
            .map { $0.isDouble || $0.count == 0 }
            .sink { [weak self] value in
                guard let self else { return }
                self.productPriceIsValid = value
            }
            .store(in: &cancellables)
    }

    func observeProduct() {
        $product
            .sink { [weak self] newValue in
                guard let self else { return }
                if self.product != newValue {
                    self.product = newValue
                }
            }
            .store(in: &cancellables)
    }

    func observeImageChanges() {
        $image
            .dropFirst()
            .sink { [weak self] photo in
                guard let self else { return }
                if let image: UIImage = photo {

                    try? ZFileManager.saveImage(
                        productImage: image,
                        name: "\(self.product.id ?? UUID())"
                    )

                    dataService.addPhoto(product: self.product)
                }
            }
            .store(in: &cancellables)
    }
}
