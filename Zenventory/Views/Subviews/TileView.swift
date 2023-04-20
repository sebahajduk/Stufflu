//
//  TileView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

struct TileView: View {

    var title: String
    var image: String

    var body: some View {
        Text(title)
            .foregroundColor(ZColor.foreground)
            .font(.footnote.bold())
            .frame(maxWidth: .infinity, maxHeight: 100)
            .padding(30)
            .background(ZColor.background)
            .cornerRadius(20)
            .shadow(color: ZColor.foreground.opacity(0.1), radius: 10)
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
    }
}
