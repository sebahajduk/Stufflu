//
//  CameraView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 15/08/2023.
//

import SwiftUI

struct CameraView: View {

    @Binding var image: UIImage?

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.backgroundColor()
                        .ignoresSafeArea()
                    ProgressView()
                    if let image {
                        VStack(spacing: 30.0) {
                            Image(uiImage: image)
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
                                } label: {
                                    Image(systemName: "arrow.triangle.2.circlepath.camera")
                                        .font(.headline)
                                }
                                .buttonStyle(StandardButton())
                            }
                            .padding()
                        }
                    } else {
                        CustomCameraView(image: self.$image)
                            .ignoresSafeArea()
                    }
                }
            }
        }
    }
}
