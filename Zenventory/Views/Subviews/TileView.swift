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
            .foregroundColor(ZColor.action)
            .font(.footnote.bold())
            .frame(maxWidth: .infinity, maxHeight: 70)
            .padding()
            .background(ZColor.background)
            .cornerRadius(30)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(ZColor.action.opacity(0.2), lineWidth: 1)
            }
            .shadow(color: ZColor.foreground.opacity(0.1), radius: 10)
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
    }
}
