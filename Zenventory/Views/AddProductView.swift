//
//  AddProductView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI
import PhotosUI


struct AddProductView: View {

    @StateObject private var vm = AddProductVModel()

    var body: some View {
        NavigationStack {
            ZStack {
                ZColor.background
                VStack(spacing: 20) {
                    PhotosPicker(selection: $vm.selectedItem, matching: .images, photoLibrary: .shared()) {
                        if vm.productImage == nil {
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .foregroundColor(ZColor.foreground)
                                .background(.clear)
                                .padding(.bottom, 50)
                        } else {
                            Image(uiImage: vm.productImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .padding(.bottom, 50)
                        }
                    }

                    VStack(spacing: 20) {
                        TextFieldWithStatus(isValid: $vm.nameIsValid,
                                            textFieldValue: $vm.productName,
                                            textFieldLabel: "Name*",
                                            keyboardType: .default)

                        TextFieldWithStatus(isValid: $vm.guaranteeIsValid,
                                            textFieldValue: $vm.productGuarantee,
                                            textFieldLabel: "Guarantee (months)",
                                            keyboardType: .default)

                        TextFieldWithStatus(isValid: $vm.careNameIsValid,
                                            textFieldValue: $vm.productCareName,
                                            textFieldLabel: "Care name (cleaning, insurance etc.)",
                                            keyboardType: .default)

                        TextFieldWithStatus(isValid: $vm.careIntervalIsValid,
                                            textFieldValue: $vm.productCareInterval,
                                            textFieldLabel: "Care interval (months)",
                                            keyboardType: .numberPad)

                        TextFieldWithStatus(isValid: $vm.priceIsValid,
                                            textFieldValue: $vm.productPrice,
                                            textFieldLabel: "Price",
                                            keyboardType: .decimalPad)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)

                    Text("Importance: " + String(Int(vm.importanceSlider)))
                    Slider(value: $vm.importanceSlider, in: 0...10, step: 1)
                        .padding(.horizontal)

                    NavigationLink("Receipt & invoice") {
                        AddProductView()
                    }

                    Button("Add product") { }
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

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
