//
//  ZenventoryApp.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

@main
struct ZenventoryApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}
