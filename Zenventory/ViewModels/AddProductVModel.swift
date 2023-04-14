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
    private var selectedImageData: Data?

    @Published var productName: String = ""
    @Published var productImage: UIImage? = UIImage(systemName: "camera.circle.fill")
    @Published var productAlert: String = ""
    @Published var productGuarantee: String = ""
    @Published var productDescription: String = ""
    @Published var productFavorite: Bool = false
    @Published var productImportance: Int = 0
    @Published var productCareName: String = ""
    @Published var productCareInterval: String = ""
    @Published var productLastUsed: Date = Date()

    @Published var importanceSlider: Double = 5

    init() {
        observeSelectedItem()
    }


    func observeSelectedItem() {
        $selectedItem
            .compactMap { $0 }
            .tryAwaitMap {
                try await $0.loadTransferable(type: Data.self)!
            }
            .receive(on: RunLoop.main)
            .sink { value in
                self.productImage = UIImage(data: value)
            }
            .store(in: &cancellables)
    }
}
