//
//  CustomCameraView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 16/08/2023.
//

import SwiftUI
import AVFoundation

struct CustomCameraView: View {
    @Binding var image: UIImage?
    @Binding var imageForViewUpdates: UIImage?
    @State var didTapCapture: Bool = false

    var body: some View {
        VStack {
            CustomCameraRepresentable(
                image: $image,
                didTapCapture: $didTapCapture,
                imageForViewUpdates: $imageForViewUpdates
            )
            Spacer()
            Button {
                didTapCapture = true
            } label: {
                Image(systemName: "camera")
            }
            .buttonStyle(StandardButton())
            .padding(.bottom, 30.0)
            Spacer()
        }
    }
}
