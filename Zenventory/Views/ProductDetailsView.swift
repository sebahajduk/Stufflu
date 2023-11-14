//
//  ProductDetailsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI
import PhotosUI

struct ProductDetailsView: View {

    @StateObject private var productDetailsViewModel: ProductDetailsViewModel

    init(
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
            ScrollView {
            VStack {
                if let image = productDetailsViewModel.image {
                    if productDetailsViewModel.isEditing {
                        NavigationLink {
                            CameraView(image: $productDetailsViewModel.image, imageForViewUpdates: productDetailsViewModel.image)
                        } label: {
                            ZStack {
                                Image(uiImage: image)
                                    .roundedImage(size: 100.0, action: true)
                                    .overlay(alignment: .topTrailing) {
                                        Button {
                                            productDetailsViewModel.deletePhoto()
                                        } label: {
                                            Image(systemName: "x.circle.fill")
                                                .frame(width: 30.0, height: 30.0)
                                                .foregroundColor(.red)
                                        }
                                        .padding(15)
                                    }
                            }
                        }
                    } else {
                        NavigationLink {
                            FullscreenPhotoView(
                                image: $productDetailsViewModel.image
                            )
                        } label: {
                            Image(uiImage: image)
                                .roundedImage(size: 100.0, action: true)
                        }
                    }
                } else {
                    NavigationLink {
                        CameraView(image: $productDetailsViewModel.image, imageForViewUpdates: productDetailsViewModel.image)
                    } label: {
                        if let image = productDetailsViewModel.image {
                            Image(uiImage: image)
                                .roundedImage(size: 100.0, action: true)
                        } else {
                            Image(systemName: "camera.macro.circle.fill")
                                .roundedImage(size: 100.0, action: productDetailsViewModel.isEditing)
                        }
                    }
                }

                viewDetails()
            }
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

    private func productParameterNotEditable(
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

    private func productParameterEditable(
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
                            .stroke(Color.actionColor(), lineWidth: 1.0)
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

    // swiftlint: disable function_body_length
    private func viewDetails() -> some View {
        VStack(alignment: .center) {

            if productDetailsViewModel.isEditing {
                TextFieldWithStatus(
                    isValid: $productDetailsViewModel.productNameIsValid,
                    textFieldValue: $productDetailsViewModel.productName,
                    textFieldLabel: productDetailsViewModel.getName(),
                    keyboardType: .default
                )
                .frame(minHeight: 30.0)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .stroke(Color.actionColor(), lineWidth: 1.0)
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
                    image: $productDetailsViewModel.invoiceImage
                )
            } label: {
                Text("Receipt / invoice")
            }

            Section {
                HStack(alignment: .top) {
                    productParameterNotEditable(
                        name: "Last used",
                        value: productDetailsViewModel.productLastUsed
                    )

                    productParameterNotEditable(
                        name: "Last cared",
                        value: productDetailsViewModel.productLastCared
                    )
                }

                HStack(alignment: .top) {
                    productParameterEditable(
                        name: "Care name",
                        value: productDetailsViewModel.getCareName(),
                        textFieldBinding: $productDetailsViewModel.productCareName,
                        textFieldValid: $productDetailsViewModel.productCareNameIsValid
                    )

                    productParameterEditable(
                        name: "Care interval",
                        value: productDetailsViewModel.getCareInterval(),
                        textFieldBinding: $productDetailsViewModel.productCareInterval,
                        textFieldValid: $productDetailsViewModel.productCareIntervalIsValid
                    )
                }

                HStack(alignment: .top) {
                    productParameterEditable(
                        name: "Guarantee",
                        value: productDetailsViewModel.getGuarantee(),
                        textFieldBinding: $productDetailsViewModel.productGuarantee,
                        textFieldValid: $productDetailsViewModel.productGuaranteeIsValid
                    )

                    productParameterEditable(
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
                    .frame(minHeight: 100.0)
                    .padding(10.0)
                    .scrollContentBackground(.hidden)
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(Color.actionColor(), lineWidth: 1.0)
                    )
                    .font(.headline)

            } else {
                ScrollView {
                    Text(productDetailsViewModel.getDescription())
                        .padding(.bottom, 20.0)
                }

            }
        }
        .padding(.horizontal)
        .navigationTitle("")
    }
    // swiftlint: enable function_body_length
}
