//
//  ProductDetailsVM.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI
import Combine
import PhotosUI

internal final class ProductDetailsViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = .init()
    unowned internal var dataService: any CoreDataManager

    @Published internal var product: ProductEntity
    @Published internal var image: UIImage?
    @Published internal var invoiceImage: UIImage?

    @Published internal var isEditing: Bool = false

    /// TextFields binders
    @Published internal var productLastUsed: String = .init()
    @Published internal var productName: String = .init()
    @Published internal var productCareName: String = .init()
    @Published internal var productCareInterval: String = .init()
    @Published internal var productLastCared: String = .init()
    @Published internal var productGuarantee: String = .init()
    @Published internal var productPrice: String = .init()
    @Published internal var productDescription: String = .init()

    /// TextFields inputs check
    @Published internal var productCareNameIsValid: Bool = true
    @Published internal var productNameIsValid: Bool = true
    @Published internal var productLastUsedIsValid: Bool = true
    @Published internal var productCareIntervalIsValid: Bool = true
    @Published internal var productLastCaredIsValid: Bool = true
    @Published internal var productGuaranteeIsValid: Bool = true
    @Published internal var productPriceIsValid: Bool = true

    /// Photo picker binding
    @Published internal var photosPickerItem: PhotosPickerItem?
    
    internal init(
        product: ProductEntity,
        dataService: any CoreDataManager
    ) {
        self.product = product
        self.dataService = dataService
        
        self.productName = product.name ?? "Unknown"
        image = try? ZFileManager.getImage(name: product.productPhotoPath ?? "Unknown")
        invoiceImage = try? ZFileManager.getImage(name: product.productInvoicePath ?? "Unknown")

        self.productDescription = product.productDescr ?? "-"

        runObservers()
    }

    deinit { }

    // MARK: Textfield data observers
    private func dataIsValid() -> Bool {
        productCareNameIsValid &&
        productNameIsValid &&
        productCareIntervalIsValid &&
        productGuaranteeIsValid &&
        productPriceIsValid
    }

    private func runObservers() {
        observeCareNameTextField()
        observeNameTextField()
        observeCareIntervalTextField()
        observeGuaranteeTextField()
        observePriceTextField()
        observeImageChanges()
        observeProduct()
    }

    internal func deletePhoto() {
        try? ZFileManager.deleteImage(name: product.productPhotoPath ?? "Unknown")
        dataService.deletePhoto(product: product)

        self.image = nil

    }

    private func observeCareNameTextField() {
        $productCareName
            .map { $0.count == 0 || $0.count > 3 }
            .assign(to: \.productCareNameIsValid, on: self)
            .store(in: &cancellables)
    }

    private func observeNameTextField() {
        $productName
            .map { $0.count > 3 }
            .assign(to: \.productNameIsValid, on: self)
            .store(in: &cancellables)
    }

    private func observeCareIntervalTextField() {
        $productCareInterval
            .map { $0.isInteger }
            .assign(to: \.productCareIntervalIsValid, on: self)
            .store(in: &cancellables)
    }

    private func observeGuaranteeTextField() {
        $productGuarantee
            .map { $0.isInteger }
            .assign(to: \.productGuaranteeIsValid, on: self)
            .store(in: &cancellables)
    }

    private func observePriceTextField() {
        $productPrice
            .map { $0.isDouble || $0.count == 0 }
            .assign(to: \.productPriceIsValid, on: self)
            .store(in: &cancellables)
    }

    // MARK: Action handlers

    internal func editButtonTapped() {
        withAnimation {
            isEditing = true
        }
    }

    private func observeProduct() {
        $product
            .sink { [weak self] newValue in
                guard let self else { return }
                if self.product != newValue {
                    self.product = newValue
                    print("changed")
                }
            }
            .store(in: &cancellables)
            
    }

    internal func saveButtonTapped() {
        if dataIsValid() {
            product.name = productName

            if productCareName.count > 3 {
                product.careName = productName
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

    private func observeImageChanges() {
        $photosPickerItem
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
                    self.image = image
                    try? ZFileManager.saveImage(productImage: image, name: "\(self.product.id ?? UUID())")
                    
                    dataService.addPhoto(product: self.product)
                }
            }
            .store(in: &cancellables)
    }

    internal func cancelButtonTapped() {
        withAnimation {
            isEditing = false
        }
    }

    // MARK: Product GETTERS

    internal func getCareInterval() -> String {
        product.careInterval != 0 ? String(product.careInterval) : "-"
    }

    internal func getCareName() -> String {
        if let careName = product.careName {
            return careName
        } else {
            return "-"
        }
    }

    internal func getFavorite() -> Bool {
        product.favorite
    }

    internal func getGuarantee() -> String {
        product.guarantee != 0 ? String(product.guarantee) : "-"
    }

    internal func getImportance() -> String {
        if let importance = product.importance {
            return importance
        } else {
            return "-"
        }
    }

    internal func getLastCared() -> String {
        product.lastCared?.asString() ?? "-"
    }

    internal func getLastUsed() -> String {
        product.lastCared?.asString() ?? "-"
    }

    internal func getName() -> String {
        product.name ?? "Unknown"
    }

    internal func getPrice() -> String {
        product.price != 0 ? String(product.price) : "-"
    }

    internal func getDescription() -> String {
        product.productDescr ?? "-"
    }

}
