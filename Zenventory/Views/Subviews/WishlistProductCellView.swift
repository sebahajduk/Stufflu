//
//  WishlistProductCell.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 20/05/2023.
//

import SwiftUI

internal struct WishlistProductCellView: View {

    //    @ObservedObject internal var wishlistProductCellViewModel: WishlistProductCellViewModel

    //    init(
    //        product: ProductEntity
    //    ) {
    //        _wishlistProductCellViewModel = ObservedObject(
    //            wrappedValue: WishlistProductCellViewModel(product: product)
    //        )
    //    }

    var body: some View {
        ZStack {
            Color.backgroundColor()

            VStack(alignment: .center, spacing: 5) {
                Text("Product name")
                    .font(.headline)
                    .foregroundColor(.actionColor())
                    .multilineTextAlignment(.leading)

                HStack {
                    Text("Days left: 10")
                        .font(.subheadline)
                    Spacer()
                    Text("$100")
                        .font(.subheadline)
                }
            }
            .padding()
            .background (
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.actionColor().opacity(0.7), lineWidth: 1)
                    .shadow(color: Color.actionColor(), radius: 5)
            )
        }
    }
}

private struct WishlistProductCellView_Previews: PreviewProvider {

    static var previews: some View {
        WishlistProductCellView()
    }
}
