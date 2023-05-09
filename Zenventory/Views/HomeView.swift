//
//  ContentView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

internal struct HomeView: View {

    @StateObject private var vm: HomeViewModel

    internal init(
        coreDataService: any CoreDataManager
    ) {
        _vm = StateObject(wrappedValue: HomeViewModel(dataService: coreDataService))
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                NavigationLink(destination: MyProductsView(coreDataService: vm.dataService)) {
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
                ForEach(vm.products, id: \.self) { entity in
                    NavigationLink(
                        destination: ProductDetailsView(product: entity)
                    ) {
                        ProductCell(productEntity: entity)
                    }
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: vm.deleteItem)
            }
            .listStyle(.plain)
            .background(Color.backgroundColor())
        }
        .padding(.horizontal)
        .background(Color.backgroundColor())
        .toolbar(.hidden, for: .navigationBar)
    }
}

private struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
    }
}
