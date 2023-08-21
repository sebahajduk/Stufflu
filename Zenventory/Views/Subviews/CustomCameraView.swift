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
    @State var didTapCapture: Bool = false

    var body: some View {
        VStack {
            CustomCameraRepresentable(
                image: self.$image, 
                didTapCapture: $didTapCapture
            )
            Spacer()
            Button {
                self.didTapCapture = true
            } label: {
                Image(systemName: "camera")
            }
            .buttonStyle(StandardButton())
            .padding(.bottom, 30)
            Spacer()
        }
    }
}
