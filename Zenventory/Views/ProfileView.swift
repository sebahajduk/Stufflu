//
//  ProfileView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI
import StoreKit
import MessageUI

struct ProfileView: View {
    @AppStorage("currency") var currency = "localCurrency"

    private var reviewService = ReviewService()
    @State private var todayQuote = ZenQuote(a: "", q: "") {
        didSet {
            quoteAuthor = todayQuote.a
            quote = todayQuote.q
        }
    }

    @State private var quoteAuthor = ""
    @State private var quote = ""

    @State private var mailResult: Result<MFMailComposeResult, Error>?
    @State private var isShowingMailView = false

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()

            VStack(alignment: .center) {
                VStack {
                    Text(quote)
                        .font(.headline)
                        .padding(.top, 30.0)

                    Text(quoteAuthor)
                        .font(.caption)
                }
                .foregroundStyle(Color.actionColor())
                .multilineTextAlignment(.center)
                .frame(height: 100.0)

                Spacer()

                Picker("Currency", selection: $currency) {
                    ForEach(NSLocale.isoCurrencyCodes, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .pickerStyle(.navigationLink)
                Divider()
                Spacer()

                Button {
                    self.isShowingMailView.toggle()
                } label: {
                    Text("Send feature idea")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(StandardButton())
                .disabled(!MFMailComposeViewController.canSendMail())
                .sheet(isPresented: $isShowingMailView) {
                    MailView(isShowing: $isShowingMailView, result: $mailResult)
                        .ignoresSafeArea()
                }

                Button {
                    reviewService.requestReview()
                } label: {
                    Text("Rate us!")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(StandardButton())

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
