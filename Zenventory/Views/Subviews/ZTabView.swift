//
//  ZTabView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

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
                        .frame(width: 25, height: 25)

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
                        .frame(width: 25, height: 25)

                    Text("Wishlist")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .wishlist ? .actionColor() : .foregroundColor().opacity(0.5))
            }

            Spacer()

            NavigationLink {
                AddProductView(coreDataService: dataService)
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.actionColor())
                        .frame(width: 60, height: 60)
                        .shadow(color: .actionColor(), radius: 10)
                    Image(systemName: "plus")
                        .resizable()
                        .bold()
                        .foregroundColor(.backgroundColor())
                        .frame(width: 20, height: 20)
                }
                .offset(y: -32)

            }

            Spacer()

            Button {
                selectedTab = .history
            } label: {
                VStack {
                    Image(systemName: "chart.xyaxis.line")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)

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
                        .frame(width: 25, height: 25)

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
