//
//  AddProductVModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI
import Combine
import PhotosUI

class AddProductVModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    @Published var selectedItem: PhotosPickerItem?

    // MARK: --- Product details ---
    @Published var productName: String = ""
    @Published var productImage: UIImage?
    @Published var productGuarantee: String = ""
    @Published var productImportance: Int = 0
    @Published var productCareName: String = ""
    @Published var productCareInterval: String = ""
    @Published var productPrice: String = ""
    @Published var importanceSlider: Double = 5

    // MARK: --- Textfields validation ---
    @Published var nameIsValid = false
    @Published var guaranteeIsValid = true
    @Published var careNameIsValid = true
    @Published var careIntervalIsValid = true
    @Published var priceIsValid = true

    init() {
        runObservers()
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
        $selectedItem
            .compactMap { $0 }
            .tryAwaitMap {
                /// Needs to be converted into Data because type Image.self does not show photos other than .png
                /// for example .heic or .jpeg
                try await $0.loadTransferable(type: Data.self)!
            }
            .receive(on: RunLoop.main)
            .sink { value in
                self.productImage = UIImage(data: value)!
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
