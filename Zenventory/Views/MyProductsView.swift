//
//  MyProductsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 23/03/2023.
//

import SwiftUI

struct MyProductsView: View {

    @StateObject var myProductsViewModel: MyProductsViewModel

    @State private var isFiltering = false

    /// temporaryProduct is assigned by swipeActions
    /// it's needed for confirmation alert to change correct product
    @State private var temporaryProduct: ProductEntity?

    init(
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
                        Text(myProductsViewModel.productsValue.asPrice())
                            .bold()

                        TextField("Search...", text: $myProductsViewModel.searchText)
                            .padding(7.0)
                            .padding(.horizontal, 25.0)
                            .background(Color(.systemGray6))
                            .cornerRadius(8.0)
                            .padding(.horizontal, 10.0)
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
                                .frame(width: 30.0, height: 30.0)
                                .foregroundColor(.foregroundColor())
                                .bold()
                        }

                        Button {
                            isFiltering = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .frame(width: 30.0, height: 30.0)
                                .foregroundColor(.foregroundColor())
                                .bold()
                        }.sheet(isPresented: $isFiltering) {
                            MyProductsFilterView(myProductsViewModel: myProductsViewModel)
                                .presentationDetents([.height(300.0)])
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 20.0)

                List {
                    ForEach(myProductsViewModel.myProducts, id: \.id) { product in
                        NavigationLink(destination: {
                            ProductDetailsView(
                                product: product,
                                dataService: myProductsViewModel.dataService
                            )
                        }, label: {
                            ProductCellView(productEntity: product)
                        })

                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                myProductsViewModel.caredActionSwiped(product)
                            } label: {
                                Label("Cared", systemImage: "checkmark")
                            }
                            .tint(.green)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                myProductsViewModel.showSellingAlert.toggle()
                                self.temporaryProduct = product
                            } label: {
                                Label("Sold", systemImage: "checkmark")
                            }
                            .tint(.cyan)
                        }
                        .alert("SoldPrice", isPresented: $myProductsViewModel.showSellingAlert) {
                            TextField("Enter price", text: $myProductsViewModel.priceEnteredInAlert)
                            Button("Cancel", role: .cancel) { }

                            Button("Save", role: .destructive) {
                                guard let temporaryProduct = temporaryProduct else { return }
                                myProductsViewModel.showSellingAlert = false
                                myProductsViewModel.sell(product: temporaryProduct)
                            }
                        }
                        .listRowBackground(Color.backgroundColor())
                        .listRowSeparator(.hidden)
                    }

                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .padding(.horizontal, 20.0)
            }
            .foregroundColor(.foregroundColor())
        }
        .navigationTitle("YOUR PRODUCTS")
        .navigationBarTitleDisplayMode(.inline)
    }
}
