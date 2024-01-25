//
//  ZTabView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI
import TipKit

@available(iOS 17.0, *)
struct AddButtonTip: Tip {
    var title: Text {
        Text("Add your first product!")
    }

    var message: Text {
        Text("Tap here.")
    }
}

struct ZTabView: View {
    @Binding var selectedTab: TabSelected

    @StateObject var dataService: CoreDataService
    @State private var isPresented: Bool = false

    var body: some View {
        HStack {
            Spacer()
            Button {
                selectedTab = .myProducts
            } label: {
                VStack {
                    Image(systemName: "backpack.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25.0, height: 25.0)

                    Text("My stuff")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .myProducts ? .actionColor() : .foregroundColor().opacity(0.5))
            }

            Spacer()

            Button {
                selectedTab = .wishlist
            } label: {
                VStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25.0, height: 25.0)

                    Text("Wishlist")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .wishlist ? .actionColor() : .foregroundColor().opacity(0.5))
            }

            Spacer()

            ZStack {
                if #available(iOS 17.0, *) {
                    TipView(AddButtonTip(), arrowEdge: .bottom)
                        .offset(y: -112.0)
                }

                NavigationLink {
                    AddProductView(coreDataService: dataService)
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(.actionColor())
                            .frame(width: 60.0, height: 60.0)
                            .shadow(color: .actionColor(), radius: 10.0)
                        Image(systemName: "plus")
                            .resizable()
                            .bold()
                            .foregroundColor(.backgroundColor())
                            .frame(width: 20.0, height: 20.0)
                    }
                    .offset(y: -32.0)
                }
                .task {
                    if #available(iOS 17.0, *) {
                        try? Tips.configure([
                            .displayFrequency(.immediate),
                            .datastoreLocation(.applicationDefault)
                        ])
                    }
                }
            }

            Spacer()

            Button {
                selectedTab = .history
            } label: {
                VStack {
                    Image(systemName: "chart.xyaxis.line")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25.0, height: 25.0)

                    Text("History")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .history ? .actionColor() : .foregroundColor().opacity(0.5))
            }

            Spacer()

            Button {
                selectedTab = .profile
            } label: {
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25.0, height: 25.0)

                    Text("Profile")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .profile ? .actionColor() : .foregroundColor().opacity(0.5))
            }

            Spacer()
        }
        .background(Color.backgroundColor())
        .buttonStyle(TapButtonStyle())
        .ignoresSafeArea()
    }
}
