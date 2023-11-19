//
//  AddProductView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI
import PhotosUI

struct AddProductView: View {

    @Environment(\.dismiss) private var dismiss

    @StateObject private var addProductViewModel: AddProductViewModel

    init(
        coreDataService: CoreDataService
    ) {
        _addProductViewModel = StateObject(
            wrappedValue: AddProductViewModel(
                dataService: coreDataService
            )
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor()
                    .ignoresSafeArea()
                    .removeFocusOnTap()

                VStack(spacing: 20.0) {
                    NavigationLink {
                        CameraView(
                            image: $addProductViewModel.productImage,
                            imageForViewUpdates: addProductViewModel.productImage
                        )
                    } label: {
                        if let image = addProductViewModel.productImage {
                            Image(uiImage: image)
                                .roundedImage(size: 100.0, action: true)
                        } else {
                            Image(systemName: "camera.circle.fill")
                                .roundedImage(size: 100.0, action: true)
                        }
                    }

                    VStack(spacing: 20.0) {
                        TextFieldWithStatus(
                            isValid: $addProductViewModel.nameIsValid,
                            textFieldValue: $addProductViewModel.productName,
                            textFieldLabel: "Name*",
                            keyboardType: .default
                        )

                        TextFieldWithStatus(
                            isValid: $addProductViewModel.guaranteeIsValid,
                            textFieldValue: $addProductViewModel.productGuarantee,
                            textFieldLabel: "Guarantee (months)",
                            keyboardType: .numberPad
                        )

                        TextFieldWithStatus(
                            isValid: $addProductViewModel.careNameIsValid,
                            textFieldValue: $addProductViewModel.productCareName,
                            textFieldLabel: "Care name (cleaning, insurance etc.)",
                            keyboardType: .default
                        )

                        TextFieldWithStatus(
                            isValid: $addProductViewModel.careIntervalIsValid,
                            textFieldValue: $addProductViewModel.productCareInterval,
                            textFieldLabel: "Care interval (months)",
                            keyboardType: .numberPad
                        )

                        TextFieldWithStatus(
                            isValid: $addProductViewModel.priceIsValid,
                            textFieldValue: $addProductViewModel.productPrice,
                            textFieldLabel: "Price",
                            keyboardType: .decimalPad
                        )
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20.0)

                    Text("Importance")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.bottom, -10.0)
                        .bold()
                        .font(.subheadline)
                        .foregroundColor(.foregroundColor())

                    Picker(
                        "Importance",
                        selection: $addProductViewModel.selectedImportance
                    ) {
                        ForEach(Importance.allCases) { importance in
                            Text(importance.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    .foregroundColor(.foregroundColor())

                    HStack(alignment: .center) {
                        Text("Receipt & invoice")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.foregroundColor())

                        Spacer()

                        NavigationLink {
                            CameraView(
                                image: $addProductViewModel.invoiceImage,
                                imageForViewUpdates: addProductViewModel.invoiceImage
                            )
                        } label: {
                            if let image = addProductViewModel.invoiceImage {
                                Image(uiImage: image)
                                    .roundedImage(size: 50.0, action: true)
                            } else {
                                Image(systemName: "doc.viewfinder.fill")
                                    .roundedImage(size: 50.0, action: true)
                            }
                        }
                    }
                    .padding()

                    Button("Add product") {
                        addProductViewModel.addButtonTapped()
                        self.dismiss()
                    }
                    .buttonStyle(StandardButton())
                }
                .padding()
            }
            .ignoresSafeArea()
            .navigationTitle("Add product")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
