//
//  FullscreenPhotoView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 26/05/2023.
//

import SwiftUI
import PhotosUI
import Combine

internal enum PhotoCategory {
    case invoice, product
}

struct FullscreenPhotoView: View {

    @ObservedObject private var fullscreenPhotoViewModel: FullscreenPhotoViewModel

    init(
        image: UIImage?,
        product: ProductEntity,
        dataService: any CoreDataManager,
        photoCategory: PhotoCategory
    ) {
        _fullscreenPhotoViewModel = ObservedObject(
            wrappedValue: FullscreenPhotoViewModel(
                image: image,
                product: product,
                dataService: dataService,
                photoCategory: photoCategory
            )
        )
    }

    var body: some View {
        ZStack {
            if let image = fullscreenPhotoViewModel.image {
                if fullscreenPhotoViewModel.isEditing {
                    PhotosPicker(
                            selection: $fullscreenPhotoViewModel.pickerImage,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            ZStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .overlay {
                                        Color.actionColor().opacity(0.5)
                                    }
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding()
                                    .shadow(radius: 10)

                                Text("Tap to change photo")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }

                        }
                } else {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .shadow(radius: 10)
                }
            } else {
                PhotosPicker(
                        selection: $fullscreenPhotoViewModel.pickerImage,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        ZStack {
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(.gray.opacity(0.05))
                                .padding()

                            Text("Tap to add invoice")
                                .font(.headline)
                        }

                    }
            }

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
