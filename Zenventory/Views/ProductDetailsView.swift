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

            if productDetailsViewModel.isEditing {
                Text("Editing")
            } else {
                viewDetails()
            }
        }
        .toolbar(content: {

            if productDetailsViewModel.isEditing {
                HStack {
                    Button("Save") { productDetailsViewModel.saveButtonTapped() }
                        .foregroundColor(.actionColor())

                    Button("Cancel") { productDetailsViewModel.cancelButtonTapped() }
                        .foregroundColor(.actionColor())
                }
            } else {
                Button("Edit") { productDetailsViewModel.editButtonTapped() }
                    .foregroundColor(.actionColor())
            }

        })
    }

    private func productParameter(
        name: String,
        value: String
    ) -> some View {
        VStack {
            Text(name)
                .font(.caption2)
                .foregroundColor(.foregroundColor().opacity(0.5))

            Text(value)
                .font(.headline)
                .foregroundColor(.foregroundColor())
        }
        .frame(maxWidth: .infinity)
    }

    private func viewDetails() -> some View {
        VStack(alignment: .center) {
            if let image = productDetailsViewModel.image {
                Image(uiImage: image)
                    .circleImage(size: 100, action: true)
            } else {
                Image(systemName: "camera.macro.circle.fill")
                    .circleImage(size: 100, action: true)
            }

            Text(productDetailsViewModel.product.name?.uppercased() ?? "Unknown")
                .multilineTextAlignment(.center)
                .foregroundColor(.foregroundColor())
                .font(.title)
                .bold()
                .padding()

            Section {
                HStack {
                    productParameter(name: "Last used", value: productDetailsViewModel.getLastUsed())
                    productParameter(name: "Care name", value: productDetailsViewModel.getCareName())
                }

                HStack {
                    productParameter(name: "Care interval", value: productDetailsViewModel.getCareInterval())
                    productParameter(name: "Last cared", value: productDetailsViewModel.getLastCared())
                }

                HStack {
                    productParameter(name: "Guarantee", value: productDetailsViewModel.getGuarantee())
                    productParameter(name: "Price", value: productDetailsViewModel.getPrice())
                }
            }
            .padding()

            Text("Description")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption2)
                .foregroundColor(.foregroundColor().opacity(0.5))
                .padding()

            Text(productDetailsViewModel.getDescription())

        }
    }
}

private struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(coreDataService: CoreDataService())
    }
}
