//
//  MyProductsFilterView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 02/05/2023.
//

import SwiftUI

struct MyProductsFilterView: View {

    @ObservedObject var vm: MyProductViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Text("Price")

                HStack {
                    TextField("Min", text: $vm.minPrice)
                        .frame(height: 30)
                        .frame(maxWidth: 60)
                        .padding(.horizontal, 25)
                        .background(.ultraThickMaterial)
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                    Divider()
                        .frame(height: 20)
                    TextField("Max", text: $vm.maxPrice)
                        .frame(height: 30)
                        .frame(maxWidth: 60)
                        .padding(.horizontal, 25)
                        .background(.ultraThickMaterial)
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                }

                Toggle("Use importance", isOn: $vm.useImportance)
                    .bold()
                    .padding(.horizontal, 100)
                    .padding(.top)
                    .tint(ZColor.action)


                Picker("Importance", selection: $vm.importance) {
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
                    .foregroundColor(ZColor.action)
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        vm.clearFilters()
                    }
                    .foregroundColor(ZColor.action)
                }
            }

        }
    }

    
}

