//
//  FullscreenPhotoViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 30/05/2023.
//

import SwiftUI
import PhotosUI
import Combine

final internal class FullscreenPhotoViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = .init()
    unowned private var dataService: any CoreDataManager
    private var product: ProductEntity
    private var photoCategory: PhotoCategory?

    @Published var image: UIImage?
    @Published var pickerImage: PhotosPickerItem? = nil
    @Published internal var isEditing: Bool = false

    init(
        image: UIImage?,
        product: ProductEntity,
        dataService: any CoreDataManager,
        photoCategory: PhotoCategory
    ) {
        self.image = image
        self.product = product
        self.dataService = dataService
        self.photoCategory = photoCategory

        observePicker()
    }

    private func observePicker() {
        $pickerImage
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
                    withAnimation(.linear(duration: 0.7)) {
                        self.isEditing = false
                        self.image = image
                    }

                    savePhoto(image)
                }
            }
            .store(in: &cancellables)
    }

    internal func editButtonTapped() {
        withAnimation {
            isEditing = true
        }
    }

    internal func saveButtonTapped() {
        withAnimation {
            isEditing = false
        }
    }

    private func savePhoto(_ image: UIImage) {
        switch photoCategory {
        case .invoice:
            try? ZFileManager.saveImage(productImage: image, name: "\(product.id ?? UUID())Invoice")
            dataService.addInvoicePhoto(product: product)
        case .product:
            try? ZFileManager.saveImage(productImage: image, name: "\(product.id ?? UUID())")
            dataService.addPhoto(product: product)
        case .none:
            #warning("Error handling")
            print("FATAL ERROR")
        }
    }

}
