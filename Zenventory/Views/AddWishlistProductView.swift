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

    #warning("Move to viewmodel")

    /// WishlistProduct parameters:
    /// - daysCounter (Date - user writes Integer, then program should add days number and save final date as Date
    ///     it will be easier to check days left when user open apps few times in a month + push notifications)
    /// - link (optional String)
    /// - name (3+ letters String)
    /// - price (optional Double)
    @State private var daysCounterTextField: String = .init()
    @State private var linkTextField: String = .init()
    @State private var nameTextField: String = .init()
    @State private var priceTextField: String = .init()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor()
                    .ignoresSafeArea()

                VStack {
                    TextField("Name*", text: $nameTextField)
                    TextField("Days to remind*", text: $daysCounterTextField)
                    TextField("Link", text: $linkTextField)
                    TextField("Price", text: $priceTextField)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding()
            }
            .toolbar {
                Button("Add") {
                    addWishlistProductViewModel.addWishlistProduct(
                        days: daysCounterTextField,
                        link: linkTextField,
                        name: nameTextField,
                        price: priceTextField
                    )
                    self.dismiss()
                }
                .foregroundStyle(Color.actionColor())
            }
        }
    }
}
