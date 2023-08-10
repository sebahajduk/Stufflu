//
//  WishlistProductCell.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 20/05/2023.
//

import SwiftUI

internal struct WishlistProductCellView: View {

    @StateObject private var wishlistProductCellViewModel: WishlistProductCellViewModel

    init(for product: WishlistEntity) {
        _wishlistProductCellViewModel = StateObject(
            wrappedValue: WishlistProductCellViewModel(
                for: product
            )
        )
    }

    var body: some View {
        ZStack {
            Color.backgroundColor()

            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(wishlistProductCellViewModel.product.name ?? "")
                        .font(.headline)
                        .foregroundColor(.actionColor())

                    HStack {
                        Text("Days left: " + wishlistProductCellViewModel.daysLeft)
                            .font(.subheadline)
                        Spacer()
                        Text(wishlistProductCellViewModel.product.price.asPrice())
                            .font(.subheadline)
                    }
                }

                if wishlistProductCellViewModel.product.link!.isValidURL {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.actionColor())
                } else {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.backgroundColor())
                }
            }
            .padding(10)
        }
    }
}
