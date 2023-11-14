//
//  MyProductsFilterView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 02/05/2023.
//

import SwiftUI

struct MyProductsFilterView: View {

    @ObservedObject var myProductsViewModel: MyProductsViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Text("Price")

                HStack {
                    TextField("Min", text: $myProductsViewModel.minPrice)
                        .modifier(PriceTextField())

                    Divider()
                        .frame(height: 20.0)

                    TextField("Max", text: $myProductsViewModel.maxPrice)
                        .modifier(PriceTextField())
                }

                Toggle(
                    "Use importance",
                    isOn: $myProductsViewModel.useImportance
                )
                .bold()
                .padding(.horizontal, 100.0)
                .padding(.top)
                .tint(.actionColor())

                Picker(
                    "Importance",
                    selection: $myProductsViewModel.importance
                ) {
                    ForEach(Importance.allCases) { importance in
                        Button(importance.rawValue.capitalized) {
                            myProductsViewModel.importance = importance
                        }
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .disabled(!myProductsViewModel.useImportance)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Filter") {
                        myProductsViewModel.filter {
                            self.dismiss()
                        }
                    }
                    .foregroundColor(.actionColor())
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        myProductsViewModel.clearFilters()
                    }
                    .foregroundColor(.actionColor())
                }
            }
        }
    }
}
