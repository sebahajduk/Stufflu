//
//  WishlistProductCell.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 20/05/2023.
//

import SwiftUI

internal struct WishlistProductCellView: View {

//        @ObservedObject internal var wishlistProductCellViewModel: WishlistProductCellViewModel
//
//        init(
//            product: ProductEntity
//        ) {
//            _wishlistProductCellViewModel = ObservedObject(
//                wrappedValue: WishlistProductCellViewModel(product: product)
//            )
//        }

    var body: some View {
        ZStack {
            Color.backgroundColor()

            VStack(alignment: .leading, spacing: 10) {
                Text("Product name")
                    .font(.headline)
                    .foregroundColor(.actionColor())

                HStack {
                    Text("Days to think over: 10")
                        .font(.subheadline)
                    Spacer()
                    Text("$100")
                        .font(.subheadline)
                }
            }
            .padding(10)
        }
    }
}

private struct WishlistProductCellView_Previews: PreviewProvider {

    static var previews: some View {
        WishlistProductCellView()
    }
}
