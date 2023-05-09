//
//  MyProductsFilterView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 02/05/2023.
//

import SwiftUI

internal struct MyProductsFilterView: View {

    @ObservedObject internal var vm: MyProductViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Text("Price")

                HStack {
                    TextField("Min", text: $vm.minPrice)
                        .modifier(PriceTextField())

                    Divider()
                        .frame(height: 20)

                    TextField("Max", text: $vm.maxPrice)
                        .modifier(PriceTextField())
                }

                Toggle(
                    "Use importance",
                    isOn: $vm.useImportance
                )
                .bold()
                .padding(.horizontal, 100)
                .padding(.top)
                .tint(.actionColor())

                Picker(
                    "Importance",
                    selection: $vm.importance
                ) {
                    ForEach(Importance.allCases) { importance in
                        Button(importance.rawValue.capitalized) {
                            vm.importance = importance

                        }
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .disabled(!vm.useImportance)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Filter") {
                        vm.filter() {
                            self.dismiss()
                        }
                    }
                    .foregroundColor(.actionColor())
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        vm.clearFilters()
                    }
                    .foregroundColor(.actionColor())
                }
            }
        }
    }
}
