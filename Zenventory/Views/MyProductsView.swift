//
//  MyProductsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 23/03/2023.
//

import SwiftUI

struct MyProductsView: View {

    @StateObject var vm: MyProductViewModel

    @FocusState private var focusField: Bool?

    init(coreDataService: CoreDataService) {
        _vm = StateObject(wrappedValue: MyProductViewModel(dataService: coreDataService))
    }

    var body: some View {
        ZStack {
            ZColor.background
                .ignoresSafeArea()
            VStack {
                ZStack(alignment: .top) {
                    VStack {
                        Text("Total value")
                        Text("$12 332.00")
                            .bold()

                        TextField("Search ...", text: $vm.searchText)
                            .padding(7)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                            .overlay(alignment: .leading) {
                                Image(systemName: "magnifyingglass")
                                    .padding()
                            }
                            .submitLabel(.done)
                    }

                    HStack {
                        Menu {
                            ForEach(SortingType.allCases) { type in
                                Button(type.rawValue) {
                                    vm.sortingType = type
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                                .frame(width: 30, height: 30)
                        }

                        Menu {
                            
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .frame(width: 30, height: 30)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 20)

                List {
                    ForEach(vm.myProducts) { product in
                        ProductCell(productEntity: product)
                    }
                    .listRowSeparator(.hidden)
                }
                .listRowBackground(ZColor.background)
                .listStyle(.plain)
                .padding(.horizontal, 20)
            }
            .foregroundColor(ZColor.foreground)
        }
        .navigationTitle("YOUR PRODUCTS")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyProductsView_Previews: PreviewProvider {

    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
    }
}
