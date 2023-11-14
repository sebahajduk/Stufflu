//
//  CameraView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 15/08/2023.
//

import SwiftUI
import Combine

struct CameraView: View {

    var cancellables = Set<AnyCancellable>()

    @Binding var image: UIImage?
    @State var imageForViewUpdates: UIImage?

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Color.backgroundColor()
                        .ignoresSafeArea()
                    ProgressView()
                    if let imageForViewUpdates {
                            VStack(spacing: 30.0) {
                                Image(uiImage: imageForViewUpdates)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)

                                HStack {
                                    Button {

                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                            .font(.headline)
                                    }
                                    .buttonStyle(StandardButton())
                                    Spacer()
                                    Button {
                                        self.image = nil
                                        self.imageForViewUpdates = nil
                                    } label: {
                                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                                            .font(.headline)
                                    }
                                    .buttonStyle(StandardButton())
                                }
                                .padding()
                            }
                    } else {
                        CustomCameraView(image: $image, imageForViewUpdates: $imageForViewUpdates)
                            .ignoresSafeArea()
                    }
                }
            }
        }
    }
}
