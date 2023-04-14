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

    @State private var selectedTab: TabSelected = .home
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .home:
                NavigationView {
                    HomeView()
                }
            case .profile:
                NavigationView {
                    ProfileView()
                }
            }

            ZTabView(selectedTab: $selectedTab)
                .frame(height: 50)
        }
        .background(ZColor.background)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
