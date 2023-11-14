//
//  AddWishlistProductView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 18/07/2023.
//

import SwiftUI

struct AddWishlistProductView: View {

    @StateObject private var addWishlistProductViewModel: AddWishlistProductViewModel
    @Environment(\.dismiss) var dismiss

    init(dataService: any CoreDataManager) {
        _addWishlistProductViewModel = StateObject(
            wrappedValue: AddWishlistProductViewModel(
                dataService: dataService
            ))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor()
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    TextFieldWithStatus(
                        isValid: $addWishlistProductViewModel.nameIsValid,
                        textFieldValue: $addWishlistProductViewModel.nameTextField,
                        textFieldLabel: "Name*",
                        keyboardType: .default
                    )

                    TextFieldWithStatus(
                        isValid: $addWishlistProductViewModel.daysCounterIsValid,
                        textFieldValue: $addWishlistProductViewModel.daysCounterTextField,
                        textFieldLabel: "Days to remind*",
                        keyboardType: .numberPad
                    )

                    TextFieldWithStatus(
                        isValid: $addWishlistProductViewModel.linkIsValid,
                        textFieldValue: $addWishlistProductViewModel.linkTextField,
                        textFieldLabel: "Link",
                        keyboardType: .default
                    )

                    TextFieldWithStatus(
                        isValid: $addWishlistProductViewModel.priceIsValid,
                        textFieldValue: $addWishlistProductViewModel.priceTextField,
                        textFieldLabel: "Price",
                        keyboardType: .decimalPad
                    )
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20.0)
                .padding()
            }
            .navigationTitle("Add wishlist product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Add") {
                    addWishlistProductViewModel.addWishlistProduct(
                        days: addWishlistProductViewModel.daysCounterTextField,
                        link: addWishlistProductViewModel.linkTextField,
                        name: addWishlistProductViewModel.nameTextField,
                        price: addWishlistProductViewModel.priceTextField
                    ) { added in
                        switch added {
                        case true:
                            self.dismiss()
                        case false:
                            print()
                        }
                    }
                }
                .foregroundStyle(Color.actionColor())
            }
        }
    }
}
