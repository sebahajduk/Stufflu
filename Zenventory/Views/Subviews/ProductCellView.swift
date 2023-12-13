//
//  SwiftUIView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 03/04/2023.
//

import SwiftUI

struct ProductCellView: View {

    @ObservedObject private var productCellViewModel: ProductCellViewModel

    init(productEntity: ProductEntity) {
        _productCellViewModel = ObservedObject(
            wrappedValue: ProductCellViewModel(
                product: productEntity
            )
        )
    }

    var body: some View {
        HStack {
            if let image = productCellViewModel.productImage {
                Image(uiImage: image)
                    .roundedImage(size: 60.0, action: false)
            } else {
                Image(systemName: "camera.macro.circle.fill")
                    .roundedImage(size: 60.0, action: false)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(productCellViewModel.product.name ?? "")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.foregroundColor())

                Text("Last used: \(productCellViewModel.lastUsed)")
                    .font(.caption2)
                    .foregroundColor(.gray)

                Text(productCellViewModel.product.productDescr ?? "")
                    .font(.system(size: 10.0))
                    .padding(.top, 5.0)
                    .padding(.trailing, 50.0)
                    .foregroundColor(.foregroundColor())
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 90.0)
        .background(Color.backgroundColor())
        .listRowBackground(Color.backgroundColor())
        .cornerRadius(30.0)
        .overlay {
            RoundedRectangle(cornerRadius: 30.0)
                .stroke(productCellViewModel.isUnused ? .red : .gray.opacity(0.2), lineWidth: 1.0)
        }
    }
}
