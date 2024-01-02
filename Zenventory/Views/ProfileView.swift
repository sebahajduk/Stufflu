//
//  ProfileView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI
import StoreKit

struct ProfileView: View {

    @Environment(\.requestReview) private var requestReview

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

                Button("Rate us!") {
                    requestReview()
                }
                .buttonStyle(StandardButton())

                Spacer()
            }
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
