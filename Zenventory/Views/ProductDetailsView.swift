//
//  ProductDetailsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI

#warning("Przypominajka o przygotowaniu sezonowych produktów do nadchodzącego sezonu")

internal struct ProductDetailsView: View {

    @StateObject private var productDetailsViewModel: ProductDetailsViewModel

    internal init(
        product: ProductEntity,
        dataService: any CoreDataManager
    ) {
        _productDetailsViewModel = StateObject(
            wrappedValue: ProductDetailsViewModel(
                product: product,
                dataService: dataService
            )
        )
    }

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()
            VStack {
                if let image = productDetailsViewModel.image {
                    Image(uiImage: image)
                        .circleImage(size: 100, action: true)
                } else {
                    Image(systemName: "camera.macro.circle.fill")
                        .circleImage(size: 100, action: productDetailsViewModel.isEditing)
                }

                viewDetails()

                Spacer()
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
        .navigationBarTitleDisplayMode(.inline)
    }

    private func productParameter(
        name: String,
        value: String,
        textFieldBinding: Binding<String>,
        textFieldValid: Binding<Bool>
    ) -> some View {
        VStack {

            Text(name)
                .font(.caption2)
                .foregroundColor(.foregroundColor().opacity(0.5))

            if productDetailsViewModel.isEditing {
                TextFieldWithStatus(
                    isValid: textFieldValid,
                    textFieldValue: textFieldBinding,
                    textFieldLabel: value,
                    keyboardType: .default
                )
                    .frame(minHeight: 30)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .stroke(Color.actionColor(), lineWidth: 1)
                    )
                    .font(.headline)
                    .multilineTextAlignment(.center)

            } else {
                Text(value)
                    .font(.headline)
                    .foregroundColor(.foregroundColor())
            }
        }
        .frame(maxWidth: .infinity)
    }

    private func viewDetails() -> some View {
        VStack(alignment: .center) {

            if productDetailsViewModel.isEditing {
                TextFieldWithStatus(
                    isValid: $productDetailsViewModel.productNameIsValid,
                    textFieldValue: $productDetailsViewModel.productName,
                    textFieldLabel: productDetailsViewModel.getName(),
                    keyboardType: .default
                )
                .frame(minHeight: 30)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .stroke(Color.actionColor(), lineWidth: 1)
                )
                .font(.headline)
                .multilineTextAlignment(.center)

            } else {
                Text(productDetailsViewModel.product.name?.uppercased() ?? "Unknown")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.foregroundColor())
                    .font(.title)
                    .bold()
                    .padding()
            }

            Section {
                HStack {
                    productParameter(
                        name: "Last used",
                        value: productDetailsViewModel.getLastUsed(),
                        textFieldBinding: $productDetailsViewModel.productLastUsed,
                        textFieldValid: $productDetailsViewModel.productLastUsedIsValid
                    )

                    productParameter(
                        name: "Care name",
                        value: productDetailsViewModel.getCareName(),
                        textFieldBinding: $productDetailsViewModel.productCareName,
                        textFieldValid: $productDetailsViewModel.productCareNameIsValid
                    )
                }

                HStack {
                    productParameter(
                        name: "Care interval",
                        value: productDetailsViewModel.getCareInterval(),
                        textFieldBinding: $productDetailsViewModel.productCareInterval,
                        textFieldValid: $productDetailsViewModel.productCareIntervalIsValid
                    )

                    productParameter(
                        name: "Last cared",
                        value: productDetailsViewModel.getLastCared(),
                        textFieldBinding: $productDetailsViewModel.productLastCared,
                        textFieldValid: $productDetailsViewModel.productLastCaredIsValid
                    )
                }

                HStack {
                    productParameter(
                        name: "Guarantee",
                        value: productDetailsViewModel.getGuarantee(),
                        textFieldBinding: $productDetailsViewModel.productGuarantee,
                        textFieldValid: $productDetailsViewModel.productGuaranteeIsValid
                    )

                    productParameter(
                        name: "Price",
                        value: productDetailsViewModel.getPrice(),
                        textFieldBinding: $productDetailsViewModel.productPrice,
                        textFieldValid: $productDetailsViewModel.productPriceIsValid
                    )
                }
            }
            .padding(.vertical)

            Text("Description")
                .frame(maxWidth: .infinity)
                .font(.caption2)
                .foregroundColor(.foregroundColor().opacity(0.5))

            if productDetailsViewModel.isEditing {
                TextEditor(text: $productDetailsViewModel.productDescription)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.actionColor(), lineWidth: 1)
                    )
                    .font(.headline)

            } else {
                Text(productDetailsViewModel.getDescription())
            }
        }
        .padding(.horizontal)
    }
}

private struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(coreDataService: CoreDataService())
    }
}
