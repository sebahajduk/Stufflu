//
//  ZTabView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

struct ZTabView: View {
    @Binding var selectedTab: TabSelected
    @State private var isPresented: Bool = false

    @State var dataService: CoreDataService

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
                .foregroundColor(selectedTab == .home ? ZColor.foreground : ZColor.foreground.opacity(0.5))
            }
            Spacer()

            Button {
                isPresented = true
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(ZColor.foreground)
                        .frame(width: 60, height: 60)
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
                .foregroundColor(selectedTab == .profile ? ZColor.foreground : ZColor.foreground.opacity(0.5))
            }

            Spacer()
        }
        .background(ZColor.background)
        .buttonStyle(TabButtonStyle())
        .ignoresSafeArea()
    }
}
