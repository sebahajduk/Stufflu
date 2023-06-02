//
//  ContentView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI
import Combine

internal struct HomeView: View {

    @StateObject private var homeViewModel: HomeViewModel

    internal init(
        coreDataService: any CoreDataManager
    ) {
        _homeViewModel = StateObject(
            wrappedValue: HomeViewModel(
                dataService: coreDataService
            )
        )
    }

    var body: some View {
        NavigationStack {
        VStack(spacing: 20) {
            HStack {
                NavigationLink(
                    destination: MyProductsView(
                        coreDataService: homeViewModel.dataService
                    )
                ) {
                    TileView(title: "MY PRODUCTS", image: "products")
                }
                NavigationLink(destination: WishlistView()) {
                    TileView(title: "WISHLIST", image: "wishlist")
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 30))

            HStack {
                TileView(title: "BOUGHT", image: "products")
                TileView(title: "SOLD", image: "sold")
            }
            .contentShape(RoundedRectangle(cornerRadius: 30))

            Divider()
                .padding(.horizontal)

            Text("30 days history")
                .font(.headline)
                .foregroundColor(.foregroundColor())

            HStack(spacing: 50) {
                VStack {
                    Text("Sold")
                    Text("$102,22")
                        .bold()
                }

                Divider()
                    .frame(maxHeight: 30)

                VStack {
                    Text("Bought")
                    Text("$14,12")
                        .bold()
                }
            }
            .foregroundColor(.foregroundColor())

            Divider()
                .padding(.horizontal)

            Text("Unused for at least 30 days")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.headline)
                .bold()
                .foregroundColor(.foregroundColor())

                List {
                    ForEach(homeViewModel.products, id: \.id) { entity in
                        NavigationLink(value: entity) {
                            ProductCellView(productEntity: entity)
                        }
                        .listRowSeparator(.hidden)

                    }
                    .onDelete(perform: homeViewModel.deleteItem)
                }
                .navigationDestination(for: ProductEntity.self, destination: { product in
                    ProductDetailsView(
                        product: product,
                        dataService: homeViewModel.dataService
                    )
                })
                .listStyle(.plain)
                .background(Color.backgroundColor())
            }
        .padding(.horizontal)
        .background(Color.backgroundColor())
        }
        .toolbarRole(.navigationStack)
        .navigationBarTitleDisplayMode(.inline)

    }
}

private struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
    }
}
