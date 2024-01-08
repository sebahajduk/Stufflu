//
//  ProfileView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI
import StoreKit

struct ProfileView: View {

    private var reviewService = ReviewService()
    @State private var todayQuote = ZenQuote(a: "", q: "") {
        didSet {
            quoteAuthor = todayQuote.a
            quote = todayQuote.q
        }
    }
    @State private var quoteAuthor = ""
    @State private var quote = ""

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()

            VStack(alignment: .center) {
                Spacer()

                Group {
                    Text(quote)
                        .font(.headline)

                    Text(quoteAuthor)
                        .font(.caption)
                }
                .foregroundStyle(Color.actionColor())
                .multilineTextAlignment(.center)

                Spacer()

                Button {
                    reviewService.requestReview()
                } label: {
                    Text("Rate us!")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(StandardButton())

                Button {

                } label: {
                    Text("Delete all products")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(WarningButton())

                Spacer()
            }
            .padding(.horizontal, 30.0)
            .onAppear {
                Task {
                    ZenQuoteRequest.getQuote { quote in
                        if let quote {
                            todayQuote = quote
                        }
                    }
                }
            }
        }
    }
}
