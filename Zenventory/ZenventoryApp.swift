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
            HomeView(coreDataService: coreDataService)
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}
