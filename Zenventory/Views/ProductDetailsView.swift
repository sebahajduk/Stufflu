//
//  ProductDetailsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI
import PhotosUI

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
                    if productDetailsViewModel.isEditing {
                        PhotosPicker(
                            selection: $productDetailsViewModel.photosPickerItem,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            ZStack {
                                Image(uiImage: image)
                                    .circleImage(size: 100, action: true)
                                    .overlay(alignment: .topTrailing) {
                                        Button {
                                            productDetailsViewModel.deletePhoto()
                                        } label: {
                                            Image(systemName: "x.circle.fill")
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.red)
                                        }
                                        .padding(15)
                                    }
                            }
                        }
                    } else {
                        NavigationLink {
                            FullscreenPhotoView(
                                image: productDetailsViewModel.image,
                                product: productDetailsViewModel.product,
                                dataService: productDetailsViewModel.dataService,
                                photoCategory: .product
                            )
                        } label: {
                            Image(uiImage: image)
                                .circleImage(size: 100, action: true)
                        }
                    }
                } else {
                    PhotosPicker(
                        selection: $productDetailsViewModel.photosPickerItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        if let image = productDetailsViewModel.image {
                            Image(uiImage: image)
                                .circleImage(size: 100, action: true)
                        } else {
                            Image(systemName: "camera.macro.circle.fill")
                                .circleImage(size: 100, action: productDetailsViewModel.isEditing)
                        }
                    }
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
                    .padding(.horizontal)
            }

            NavigationLink {
                FullscreenPhotoView(
                    image: productDetailsViewModel.invoiceImage,
                    product: productDetailsViewModel.product,
                    dataService: productDetailsViewModel.dataService,
                    photoCategory: .invoice
                )
            } label: {
                Text("Receipt / invoice")
            }

            Section {
                HStack(alignment: .top) {
                    productParameter(
                        name: "Last used",
                        value: productDetailsViewModel.productLastUsed,
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

                HStack(alignment: .top) {
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

                HStack(alignment: .top) {
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
                ScrollView {
                    Text(productDetailsViewModel.getDescription())
                        .padding(.bottom, 20)
                }

            }
        }
        .padding(.horizontal)
        .navigationTitle("")
    }
}

private struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(coreDataService: CoreDataService())
    }
}
