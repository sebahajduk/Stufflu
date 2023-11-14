//
//  CustomCameraRepresentable.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 19/08/2023.
//

import SwiftUI
import AVFoundation

struct CustomCameraRepresentable {
    @Binding var image: UIImage?
    @Binding var didTapCapture: Bool
}

extension CustomCameraRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(
        context: Context
    ) -> CustomCameraController {
        let controller = CustomCameraController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(
        _ cameraViewController: CustomCameraController,
        context: Context
    ) {
        if self.didTapCapture {
            cameraViewController.didTapRecord()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension CustomCameraRepresentable {
    class Coordinator:
        NSObject,
        UINavigationControllerDelegate,
        AVCapturePhotoCaptureDelegate {
        let parent: CustomCameraRepresentable

        init(_ parent: CustomCameraRepresentable) {
            self.parent = parent
        }

        func photoOutput(
            _ output: AVCapturePhotoOutput,
            didFinishProcessingPhoto photo: AVCapturePhoto,
            error: Error?
        ) {
            parent.image = nil
            parent.didTapCapture = false

            if let imageData = photo.fileDataRepresentation() {
                parent.image = UIImage(data: imageData)
            }
        }
    }
}
