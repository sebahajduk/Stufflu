//
//  FullscreenPhotoViewModel.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 30/05/2023.
//

import SwiftUI
import PhotosUI

final class FullscreenPhotoViewModel: ObservableObject {

    @Published var isEditing: Bool = false

    func editButtonTapped() {
        withAnimation {
            isEditing = true
        }
    }

    func saveButtonTapped() {
        withAnimation {
            isEditing = false
        }
    }
}
