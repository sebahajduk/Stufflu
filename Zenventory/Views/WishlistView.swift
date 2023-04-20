//
//  WishlistView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI

struct WishlistView: View {
    var body: some View {
        ZStack {
            ZColor.background
                .ignoresSafeArea()

            ScrollView {
                ForEach(0..<10) { _ in
//                    ProductCell()
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("WISHLIST")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView()
    }
}
