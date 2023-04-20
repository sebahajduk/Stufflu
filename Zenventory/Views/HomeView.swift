//
//  ContentView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var vm: HomeViewModel

    init(coreDataService: CoreDataService) {
        _vm = StateObject(wrappedValue: HomeViewModel(dataService: coreDataService))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            NavigationLink(destination: MyProductsView()) {
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
                            .foregroundColor(ZColor.foreground)

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
                        .foregroundColor(ZColor.foreground)

                        Divider()
                            .padding(.horizontal)

                        Text("Unused for at least 30 days")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.headline)
                            .bold()
                            .foregroundColor(ZColor.foreground)
                        
                        ForEach(vm.products) { entity in
                            ProductCell(productEntity: entity)
                        }
                        Spacer()
                    }
                    .padding()
                }
                .background(ZColor.background)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
    }
}
