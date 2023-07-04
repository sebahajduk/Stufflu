//
//  WishlistView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI

internal struct WishlistView: View {

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()

            List {
                ForEach(0..<10) { _ in
                    NavigationLink {

                    } label: {
                        WishlistProductCellView()
                    }
                }
                .onDelete { _ in

                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .padding(.horizontal)
        }
        .navigationTitle("WISHLIST")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView()
    }
}
