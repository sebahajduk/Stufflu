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

    @StateObject private var vm: AddProductVModel

    internal init(
        coreDataService: CoreDataService
    ) {
        _vm = StateObject(wrappedValue: AddProductVModel(dataService: coreDataService))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ZColor.background
                VStack(spacing: 20) {
                    PhotosPicker(
                        selection: $vm.selectedProductPhoto,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        if vm.productImage == nil {
                            Image(systemName: "camera.circle.fill")
                                .circleImage(size: 100, action: true)
                        } else {
                            Image(uiImage: vm.productImage!)
                                .circleImage(size: 100, action: true)
                        }
                    }

                    VStack(spacing: 20) {
                        TextFieldWithStatus(
                            isValid: $vm.nameIsValid,
                            textFieldValue: $vm.productName,
                            textFieldLabel: "Name*",
                            keyboardType: .default
                        )

                        TextFieldWithStatus(
                            isValid: $vm.guaranteeIsValid,
                            textFieldValue: $vm.productGuarantee,
                            textFieldLabel: "Guarantee (months)",
                            keyboardType: .numberPad
                        )

                        TextFieldWithStatus(
                            isValid: $vm.careNameIsValid,
                            textFieldValue: $vm.productCareName,
                            textFieldLabel: "Care name (cleaning, insurance etc.)",
                            keyboardType: .default
                        )

                        TextFieldWithStatus(
                            isValid: $vm.careIntervalIsValid,
                            textFieldValue: $vm.productCareInterval,
                            textFieldLabel: "Care interval (months)",
                            keyboardType: .numberPad
                        )

                        TextFieldWithStatus(
                            isValid: $vm.priceIsValid,
                            textFieldValue: $vm.productPrice,
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
                        .foregroundColor(ZColor.foreground)

                    Picker(
                        "Importance",
                        selection: $vm.selectedImportance
                    ) {
                        ForEach(Importance.allCases) { importance in
                            Text(importance.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    .foregroundColor(ZColor.foreground)

                    HStack(alignment: .center) {
                        Text("Receipt & invoice")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(ZColor.foreground)

                        Spacer()

                        PhotosPicker(
                            selection: $vm.selectedProductPhoto,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            if vm.productImage == nil {
                                Image(systemName: "doc.viewfinder.fill")
                                    .circleImage(size: 50, action: true)
                            } else {
                                Image(uiImage: vm.productImage!)
                                    .circleImage(size: 50, action: true)
                            }
                        }
                    }
                    .padding()

                    Button("Add product") {
                        vm.addButtonTapped()
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
