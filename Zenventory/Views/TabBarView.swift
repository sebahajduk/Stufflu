//
//  TabView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

enum TabSelected {
    case home, profile
}

struct TabBarView: View {

    var coreDataService: CoreDataService

    @State private var selectedTab: TabSelected = .home

    var body: some View {
        NavigationStack {
            VStack {
                switch selectedTab {
                case .home:
                    NavigationView {
                        HomeView(
                            coreDataService: coreDataService
                        )
                    }
                case .profile:
                    NavigationView {
                        ProfileView()
                    }
                }

                ZTabView(
                    selectedTab: $selectedTab,
                    dataService: coreDataService
                )
                .frame(height: 50.0)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .background(Color.backgroundColor())
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
