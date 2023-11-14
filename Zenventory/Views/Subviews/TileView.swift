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
        VStack {
            Image(systemName: image)
                .foregroundColor(.actionColor())
                .font(.headline)
                .frame(maxWidth: .infinity, maxHeight: 30.0)
                .padding()
                .background(Color.backgroundColor())
                .overlay {
                    Circle()
                        .stroke(Color.actionColor().opacity(0.2), lineWidth: 1.0)
                }
            Text(title)
                .font(.caption2.bold())
                .foregroundStyle(Color.actionColor())
        }

    }
}
