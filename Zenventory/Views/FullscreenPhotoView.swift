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

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()

            if let image = image {
                if fullscreenPhotoViewModel.isEditing {
                    NavigationLink {
                        CameraView(image: $image)
                    } label: {
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .overlay {
                                    Color.actionColor().opacity(0.5)
                                }
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                                .shadow(radius: 10.0)

                            Text("Tap to change photo")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                } else {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .shadow(radius: 10.0)
                }
            } else {
                NavigationLink {
                    CameraView(image: $image)
                } label: {
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
