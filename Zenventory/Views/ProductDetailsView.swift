//
//  ProductDetailsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI
import PhotosUI

struct ProductDetailsView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject private var productDetailsViewModel: ProductDetailsViewModel
    @State private var showSellAlert = false

    @State private var photoPickerItem: PhotosPickerItem?

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
            VStack {
                ScrollView {
#if targetEnvironment(simulator)
                    simulatorPhotosPicker
#else
                    cameraNavigationLink
#endif
                    viewDetails
                }

                Spacer()

                Button("Sell product") {
                    showSellAlert.toggle()
                }
                .font(.caption)
                .bold()
                .foregroundStyle(Color.red)
                .alert("SoldPrice", isPresented: $showSellAlert) {
                    TextField("Enter price", text: $productDetailsViewModel.sellPrice)

                    Button("Cancel", role: .cancel) { }

                    Button("Save", role: .destructive) {
                        productDetailsViewModel.sellProduct()
                        dismiss()
                    }
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
}

private extension ProductDetailsView {
    var viewDetails: some View {
        VStack(alignment: .center) {
            productNameView

            NavigationLink {
                FullscreenPhotoView(
                    image: $productDetailsViewModel.invoiceImage
                )
            } label: {
                Text("Receipt / invoice")
            }

            parametersView

            descriptionView
        }
        .padding(.horizontal)
        .navigationTitle("")
    }

    var cameraNavigationLink: some View {
        NavigationLink {
            if productDetailsViewModel.isEditing || productDetailsViewModel.image == nil {
                CameraView(
                    image: $productDetailsViewModel.image,
                    imageForViewUpdates: productDetailsViewModel.image
                )
            } else {
                FullscreenPhotoView(
                    image: $productDetailsViewModel.image
                )
            }
        } label: {
            Image(systemName: "camera.macro.circle.fill")
                .roundedImage(size: 100.0, action: true)
                .overlay {
                    if let image = productDetailsViewModel.image {
                        Image(uiImage: image)
                            .roundedImage(size: 100.0, action: true)
                    }
                }
                .overlay(alignment: .topTrailing) {
                    if productDetailsViewModel.isEditing {
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
    }

    var productNameView: some View {
        Section {
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
        }
    }
    var parametersView: some View {
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
    }

    var descriptionView: some View {
        Section {
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
    }
}

private extension ProductDetailsView {
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
}

// MARK: - Simulator target
private extension ProductDetailsView {
    var simulatorPhotosPicker: some View {
        Section {
            if let image = productDetailsViewModel.image {
                cameraNavigationLink
            } else {
                PhotosPicker(selection: $photoPickerItem) {
                    Image(systemName: "camera.macro.circle.fill")
                        .roundedImage(size: 100.0, action: true)
                        .overlay {
                            if let image = productDetailsViewModel.image {
                                Image(uiImage: image)
                                    .roundedImage(size: 100.0, action: true)
                            }
                        }
                        .overlay(alignment: .topTrailing) {
                            if productDetailsViewModel.isEditing {
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
            }
        }
    }
}
