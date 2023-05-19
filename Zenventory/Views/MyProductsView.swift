//
//  MyProductsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 23/03/2023.
//

import SwiftUI

internal struct MyProductsView: View {

    @StateObject internal var myProductsViewModel: MyProductsViewModel

    @FocusState private var focusField: Bool?

    @State private var isFiltering = false

    internal init(
        coreDataService: any CoreDataManager
    ) {
        _myProductsViewModel = StateObject(
            wrappedValue: MyProductsViewModel(
                dataService: coreDataService
            )
        )
    }

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()
            VStack {
                ZStack(alignment: .top) {
                    VStack {
                        Text("Total value")
                        Text("$12 332.00")
                            .bold()

                        TextField("Search...", text: $myProductsViewModel.searchText)
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
                                    myProductsViewModel.sortingType = type
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                                .frame(width: 30, height: 30)
                                .foregroundColor(.foregroundColor())
                                .bold()
                        }

                        Button {
                            isFiltering = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .frame(width: 30, height: 30)
                                .foregroundColor(.foregroundColor())
                                .bold()
                        }.sheet(isPresented: $isFiltering) {
                            MyProductsFilterView(myProductsViewModel: myProductsViewModel)
                                .presentationDetents([.filter])
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 20)
                
                List {
                    ForEach(myProductsViewModel.myProducts) { product in
                        NavigationLink(
                            destination: ProductDetailsView(
                                product: product,
                                dataService: myProductsViewModel.dataService
                            )
                        ) {
                            ProductCell(productEntity: product)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listRowBackground(Color.backgroundColor())
                .listStyle(.plain)
                .padding(.horizontal, 20)
            }
            .foregroundColor(.foregroundColor())
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
