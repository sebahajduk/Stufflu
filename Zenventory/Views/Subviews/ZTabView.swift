//
//  ZTabView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

fileprivate struct TabButtonStyle: ButtonStyle {
    internal func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

internal struct ZTabView: View {
    @Binding internal var selectedTab: TabSelected

    @State internal var dataService: CoreDataService
    @State private var isPresented: Bool = false

    var body: some View {
        HStack {
            Spacer()
            Button {
                selectedTab = .home
            } label: {
                VStack {
                    Image(systemName: "house.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)

                    Text("Home")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .home ? ZColor.action : ZColor.foreground.opacity(0.5))
            }

            Spacer()

            Button {
                isPresented = true
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(ZColor.action)
                        .frame(width: 60, height: 60)
                        .shadow(color: ZColor.action, radius: 10)
                    Image(systemName: "plus")
                        .resizable()
                        .bold()
                        .foregroundColor(ZColor.background)
                        .frame(width: 20, height: 20)
                }
                .offset(y: -32)
            }.sheet(isPresented: $isPresented) {
                AddProductView(coreDataService: dataService)
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
                .foregroundColor(selectedTab == .profile ? ZColor.action : ZColor.foreground.opacity(0.5))
            }

            Spacer()
        }
        .background(ZColor.background)
        .buttonStyle(TabButtonStyle())
        .ignoresSafeArea()
    }
}
