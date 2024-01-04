//
//  OnboardingView.swift
//  Stufflu
//
//  Created by Sebastian Hajduk on 04/01/2024.
//

import SwiftUI

private enum OnboardingPage: CaseIterable {
    case first, second, third
}

struct OnboardingView: View {
    @AppStorage("firstLaunch") var firstLaunch = true
    @State private var page: OnboardingPage = .first

    var body: some View {
        ZStack {
            Color.actionColor()
                .ignoresSafeArea()

            VStack {
                switch page {
                case .first:
                    Text("Track usage of your stuff")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    Text("To make sure you need them")
                        .foregroundStyle(.white)

                    Spacer()

                    firstOnboardingPage
                case .second:
                    Text("Take care of belongings")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    Text("Let them be a part of your life longer")
                        .foregroundStyle(.white)

                    Spacer()

                    secondOnboardingPage
                case .third:
                    Text("Add your wishlist")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    Text("Give yourself time to consider purchases")
                        .foregroundStyle(.white)

                    Spacer()
                    thirdOnboardingPage
                }

                Spacer()
                pageControlView(for: page)

                HStack {
                    if page != .first {
                        Button("Previous") {
                            withAnimation {
                                if page == .second {
                                    page = .first
                                } else if page == .third {
                                    page = .second
                                }
                            }
                        }
                        .frame(width: 100.0, height: 40.0)
                        .foregroundStyle(Color.white)
                        .bold()
                    }

                    Spacer()
                    Button {
                        withAnimation {
                            if page == .first {
                                page = .second
                            } else if page == .second {
                                page = .third
                            } else if page == .third {
                                firstLaunch = false
                            }
                        }
                    } label: {
                        Text(page == .third ? "Get started" : "Next")
                            .frame(width: 100.0, height: 40.0)
                            .background(Color.white)
                            .clipShape(.capsule)
                    }
                }
                .frame(height: 50.0)
            }
            .padding()
        }
    }
}

#Preview {
    OnboardingView()
}

private extension OnboardingView {
    var firstOnboardingPage: some View {
        Image("firstOnboardingScreen")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(.rect(cornerRadius: 20.0))
    }

    var secondOnboardingPage: some View {
        Image("secondOnboardingScreen")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(.rect(cornerRadius: 20.0))
    }

    var thirdOnboardingPage: some View {
        Image("thirdOnboardingScreen")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(.rect(cornerRadius: 20.0))
    }
}

private extension OnboardingView {
    func pageControlView(for page: OnboardingPage) -> some View {
        HStack {
            switch page {
            case .first:
                Capsule()
                Circle()
                Circle()
            case .second:
                Circle()
                Capsule()
                Circle()
            case .third:
                Circle()
                Circle()
                Capsule()
            }
        }
        .frame(width: 60.0, height: 10.0)
        .foregroundStyle(Color.white)
    }
}
