//
//  MyProductsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 23/03/2023.
//

import SwiftUI

struct MyProductsView: View {
    let tempArr: [Product] = []

    var body: some View {
        ZStack {
            ZColor.background
                .ignoresSafeArea()
            VStack {
                ZStack(alignment: .center) {
                    VStack {
                        Text("Total value")
                        Text("$12 332.00")
                            .bold()
                    }

                    HStack {
                        Menu {

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

                ScrollView {
                    ForEach(0..<10) { _ in
                        ProductCell()
                    }
                }
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
        TabBarView()
    }
}
