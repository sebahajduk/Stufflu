//
//  FullscreenPhotoView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 26/05/2023.
//

import SwiftUI
import PhotosUI

enum PhotoCategory {
    case invoice, product
}

struct FullscreenPhotoView: View {

    @ObservedObject private var fullscreenPhotoViewModel: FullscreenPhotoViewModel = .init()
    @Binding var image: UIImage?

    // MARK: - Simulator target params
    @State private var photoPickerItem: PhotosPickerItem?

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()
                .onAppear {
                    fullscreenPhotoViewModel.isEditing = false
                }
#if targetEnvironment(simulator)
            PhotosPicker(selection: $photoPickerItem) {
                productImage
            }
            .disabled(!fullscreenPhotoViewModel.isEditing)
#else
            NavigationLink {
                CameraView(image: $image, imageForViewUpdates: image)
            } label: {
                productImage
            }
            .disabled(!fullscreenPhotoViewModel.isEditing)
#endif
        }
        .toolbar {
            HStack {
                if fullscreenPhotoViewModel.isEditing {
                    Button("Save") {
                        fullscreenPhotoViewModel.saveButtonTapped()
                    }
                } else {
                    Button("Edit") {
                        fullscreenPhotoViewModel.editButtonTapped()
                    }
                }
            }
        }
    }
}

private extension FullscreenPhotoView {
    var productImage: some View {
        Image(uiImage: image ?? SFSymbols.cameraFill)
            .resizable()
            .overlay {
                if fullscreenPhotoViewModel.isEditing {
                    ZStack {
                        Color.actionColor().opacity(0.5)

                        Text("Tap to change photo")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                    }
                }
            }
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .shadow(radius: 10.0)
    }
}
