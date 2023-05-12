//
//  ProductDetailsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI

internal struct ProductDetailsView: View {

    @StateObject private var productDetailsViewModel: ProductDetailsViewModel

    internal init(
        product: ProductEntity
    ) {
        _productDetailsViewModel = StateObject(wrappedValue: ProductDetailsViewModel(product: product))
    }

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()

            VStack(alignment: .center) {
                if productDetailsViewModel.image != nil {
                    Image(uiImage: productDetailsViewModel.image!)
                        .circleImage(size: 100, action: true)
                } else {
                    Image(systemName: "camera.macro.circle.fill")
                        .circleImage(size: 100, action: true)
                }
            }
        }
        .navigationTitle(productDetailsViewModel.product.name!)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(coreDataService: CoreDataService())
    }
}
