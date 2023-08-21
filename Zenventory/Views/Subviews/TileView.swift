//
//  TileView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

internal struct TileView: View {

    internal var title: String
    internal var image: String

    var body: some View {
        VStack {
            Image(systemName: image)
                .foregroundColor(.actionColor())
                .font(.headline)
                .frame(maxWidth: .infinity, maxHeight: 30)
                .padding()
                .background(Color.backgroundColor())
                .overlay {
                    Circle()
                        .stroke(Color.actionColor().opacity(0.2), lineWidth: 1)
                }
            Text(title)
                .font(.caption2.bold())
                .foregroundStyle(Color.actionColor())
        }

    }
}
