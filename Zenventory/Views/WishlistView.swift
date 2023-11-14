//
//  WishlistView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI

struct WishlistView: View {

    @StateObject var wishlistViewModel: WishlistViewModel

    @State private var addSheetPresented: Bool = false

    init(dataService: any CoreDataManager) {
        _wishlistViewModel = StateObject(
            wrappedValue: WishlistViewModel(
                dataService: dataService
            )
        )
    }

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()

            VStack {
                HStack {
                    TextField("Search...", text: $wishlistViewModel.searchText)
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
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .trailing)

                if !wishlistViewModel.wishlistProducts.isEmpty {
                    List {
                        ForEach(wishlistViewModel.wishlistProducts, id: \.id ) { entity in
                            if entity.link != nil && entity.link?.isValidURL ?? false {
                                Link(
                                    destination: (
                                        URL(
                                            string: entity.link ?? "https://www.google.com"
                                        )!
                                    )
                                ) {
                                    WishlistProductCellView(for: entity)
                                        .listRowBackground(Color.backgroundColor())
                                }
                            } else {
                                WishlistProductCellView(for: entity)
                                    .listRowBackground(Color.backgroundColor())
                            }
                        }
                        .onDelete {
                            wishlistViewModel.deleteWishlistProduct(at: $0)
                        }
                        .listRowSeparatorTint(Color.actionColor().opacity(0.5))
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    .padding(.horizontal)
                } else {
                    Spacer()
                }
            }
            .sheet(isPresented: $addSheetPresented) {
                AddWishlistProductView(dataService: wishlistViewModel.dataService)
                    .presentationDetents([.height(300.0)])
            }
        }
        .toolbar {
            Button {
                addSheetPresented.toggle()
            } label: {
                Text("Add")
                    .bold()
            }
        }
        .navigationTitle("WISHLIST")
        .navigationBarTitleDisplayMode(.inline)
    }
}
