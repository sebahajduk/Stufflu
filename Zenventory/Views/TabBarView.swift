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
        VStack {
            switch selectedTab {
            case .home:
                NavigationView {
                    HomeView(coreDataService: coreDataService)
                }
            case .profile:
                NavigationView {
                    ProfileView()
                }
            }

            ZTabView(selectedTab: $selectedTab, dataService: coreDataService)
                .frame(height: 50)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(ZColor.background)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct TabView_Previews: PreviewProvider {

    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
    }
}
