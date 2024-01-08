//
//  TabView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

enum TabSelected {
    case myProducts, wishlist, history, profile
}

struct TabBarView: View {
    @AppStorage("firstLaunch") var firstLaunch = true
    var coreDataService: CoreDataService

    @State private var selectedTab: TabSelected = .myProducts

    var body: some View {
        NavigationStack {
            VStack {
                switch selectedTab {
                case .myProducts:
                    NavigationView {
                        MyProductsView(
                            coreDataService: coreDataService
                        )
                    }
                case .wishlist:
                    NavigationView {
                        WishlistView(dataService: coreDataService)
                    }
                case .history:
                    NavigationView {
                        HistoryView(dataService: coreDataService)
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
            .overlay {
                if firstLaunch {
                    OnboardingView()
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .background(Color.backgroundColor())
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
