//
//  ReviewService.swift
//  Stufflu
//
//  Created by Sebastian Hajduk on 02/01/2024.
//

import SwiftUI
import StoreKit

final class ReviewService: ObservableObject {
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(
            where: {
                $0.activationState == .foregroundActive
            }
        ) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
