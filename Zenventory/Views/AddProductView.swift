//
//  AddProductView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI
import PhotosUI

internal struct AddProductView: View {

    @Environment(\.dismiss) private var dismiss

    @StateObject private var addProductViewModel: AddProductViewModel

    internal init(
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
                VStack(spacing: 20) {
                    PhotosPicker(
                        selection: $addProductViewModel.selectedProductPhoto,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        if addProductViewModel.productImage == nil {
                            Image(systemName: "camera.circle.fill")
                                .circleImage(size: 100, action: true)
                        } else {
                            Image(uiImage: addProductViewModel.productImage!)
                                .circleImage(size: 100, action: true)
                        }
                    }

                    VStack(spacing: 20) {
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
                    .cornerRadius(20)

                    Text("Importance")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.bottom, -10)
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

                        PhotosPicker(
                            selection: $addProductViewModel.selectedProductPhoto,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            if addProductViewModel.productImage == nil {
                                Image(systemName: "doc.viewfinder.fill")
                                    .circleImage(size: 50, action: true)
                            } else {
                                Image(uiImage: addProductViewModel.productImage!)
                                    .circleImage(size: 50, action: true)
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

private struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
    }
}
