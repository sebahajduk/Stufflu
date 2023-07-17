//
//  WishlistView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI

internal struct WishlistView: View {

    @State private var isFiltering: Bool = false
    @State private var searchText: String = .init()

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    TextField("Search...", text: $searchText)
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
                    
                    Menu {
                        ForEach(SortingType.allCases) { type in
                            Button(type.rawValue) {
                                #warning("Do something")
                                //                                myProductsViewModel.sortingType = type
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
                        
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                List {
                    ForEach(0..<10) { _ in
                        NavigationLink {
                            
                        } label: {
                            WishlistProductCellView()
                        }
                    }
                    .onDelete { _ in
                        
                    }
                    .listRowBackground(Color.backgroundColor())
                    .listRowSeparatorTint(Color.actionColor().opacity(0.5))
                }
                .listStyle(.plain)
                .padding(.horizontal)
            }
        }
        .toolbar {
            Button {
                #warning("Do something")
            } label: {
                Text("Add")
                    .bold()
            }
        }
        .navigationTitle("WISHLIST")
        .navigationBarTitleDisplayMode(.inline)

    }
}

private struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView()
    }
}
