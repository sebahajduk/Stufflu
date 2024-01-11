//
//  MailView.swift
//  Stufflu
//
//  Created by Sebastian Hajduk on 10/01/2024.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {

    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.mailComposeDelegate = context.coordinator
        viewController.setSubject("I have feature idea!")
        viewController.setToRecipients(["contactstufflu@gmail.com"])
        return viewController
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isShowing: $isShowing, result: $result)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(isShowing: Binding<Bool>,
             result: Binding<Result<MFMailComposeResult, Error>?>
        ) {
            _isShowing = isShowing
            _result = result
        }

        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            defer {
                isShowing = false
            }

            if let error {
                self.result = .failure(error)
                return
            } else {
                self.result = .success(result)
            }
        }
    }
}
