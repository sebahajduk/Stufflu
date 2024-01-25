//
//  ZenventoryApp.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

@main
struct ZenventoryApp: App {

    @StateObject var coreDataService = CoreDataService()

    var body: some Scene {
        WindowGroup {
            TabBarView(coreDataService: coreDataService)
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar(.hidden, for: .navigationBar)
                .onAppear {
#if DEBUG
                    UserDefaults.standard.removeObject(forKey: "firstLaunch")
#endif
                }
        }
    }
}
