//
//  SwiftUIView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 03/04/2023.
//

import SwiftUI

internal struct ProductCell: View {

    @StateObject private var productCellViewModel: ProductCellViewModel

    internal init(productEntity: ProductEntity) {
        _productCellViewModel = StateObject(
            wrappedValue: ProductCellViewModel(
                product: productEntity
            )
        )
    }

    var body: some View {
        HStack {
            if let image = productCellViewModel.productImage {
                Image(uiImage: image)
                    .circleImage(size: 60, action: false)
            } else {
                Image(systemName: "camera.macro.circle.fill")
                    .circleImage(size: 60, action: false)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(productCellViewModel.product.name ?? "")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.foregroundColor())

                Text("Last used: \(productCellViewModel.lastUsed)")
                    .font(.caption2)
                    .foregroundColor(.gray)

                Text(productCellViewModel.product.productDescr ?? "lorem ipsum lorem ipsum lorem ipsum")
                    .font(.system(size: 10))
                    .padding(.top, 5)
                    .padding(.trailing, 50)
                    .foregroundColor(.foregroundColor())
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 90)
        .background(Color.backgroundColor())
        .listRowBackground(Color.backgroundColor())
        .cornerRadius(30)
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.gray.opacity(0.2), lineWidth: 1)
        }
    }
}

private struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
     }
}
