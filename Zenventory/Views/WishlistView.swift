//
//  WishlistView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI

internal struct WishlistView: View {

    @StateObject internal var wishlistViewModel: WishlistViewModel

    @State private var addSheetPresented: Bool = false

    internal init(dataService: any CoreDataManager) {
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
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .trailing)

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
                            }
                        } else {
                            WishlistProductCellView(for: entity)
                        }
                    }
                    .onDelete {
                        wishlistViewModel.deleteWishlistProduct(at: $0)
                    }
                    .listRowSeparatorTint(Color.actionColor().opacity(0.5))
                }
                .listStyle(.plain)
                .padding(.horizontal)
            }
            .sheet(isPresented: $addSheetPresented) {
                AddWishlistProductView(dataService: wishlistViewModel.dataService)
                    .presentationDetents([.filter])
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
