//
//  ContentView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI
import Neumorphic

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
        VStack(spacing: 20) {
                HStack {
                    NavigationLink(
                        destination: MyProductsView(
                            coreDataService: homeViewModel.dataService
                        )
                    ) {
                        TileView(title: "PRODUCTS", image: "backpack.fill")
                    }

                    NavigationLink(
                        destination: WishlistView(
                            dataService: homeViewModel.dataService
                    )
                    ) {
                        TileView(title: "WISHLIST", image: "heart.fill")
                    }

                    NavigationLink(
                        destination:
                            HistoryView(
                                dataService: homeViewModel.dataService
                            )
                    ) {
                        TileView(title: "HISTORY", image: "book.fill")
                    }
                }
                .buttonStyle(TapButtonStyle())

                Divider()
                    .padding(.horizontal)

                Text("30 days history")
                    .font(.headline)
                    .foregroundColor(.foregroundColor())

                HStack(spacing: 50) {
                    VStack {
                        Text("Sold")
                        Text(homeViewModel.soldSummary.asPrice())
                            .bold()
                    }

                    Divider()
                        .frame(maxHeight: 30)

                    VStack {
                        Text("Bought")
                        Text(homeViewModel.boughtSummary.asPrice())
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

                if homeViewModel.listIsEmpty {
                    Spacer()
                    Text("There is no unused products! 🥳")
                        .font(.headline)
                        .foregroundStyle(Color.actionColor())
                    Spacer()
                } else {
                    List {
                        ForEach(homeViewModel.products, id: \.id) { entity in
                            NavigationLink(value: entity) {
                                ProductCellView(productEntity: entity)
                            }
                            .listRowBackground(Color.backgroundColor())
                            .listRowSeparator(.hidden)
                            .swipeActions(allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    homeViewModel.use(product: entity)
                                } label: {
                                    Label("Used", systemImage: "checkmark")
                                }
                                .tint(.green)
                            }
                        }
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
            }
            .padding(.top)
            .padding(.horizontal)
            .background(Color.backgroundColor())
            .toolbarRole(.navigationStack)
            .navigationBarTitleDisplayMode(.inline)
        }
}

private struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
    }
}
