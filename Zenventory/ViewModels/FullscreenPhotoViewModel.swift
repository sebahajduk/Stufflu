//
//  FullscreenPhotoViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 30/05/2023.
//

import SwiftUI
import PhotosUI

final internal class FullscreenPhotoViewModel: ObservableObject {
    unowned private var dataService: any CoreDataManager
    private var product: ProductEntity
    private var photoCategory: PhotoCategory?

    @Published var image: UIImage?
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
}
