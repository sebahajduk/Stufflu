//
//  ProductDetailsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI

struct ProductDetailsView: View {

    @StateObject var vm: ProductDetailsVM

    init(product: ProductEntity) {
        _vm = StateObject(wrappedValue: ProductDetailsVM(product: product))
    }

    var body: some View {
        ZStack {
            ZColor.background
                .ignoresSafeArea()
            VStack(alignment: .center) {
                if vm.image != nil {
                    Image(uiImage: vm.image!)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                } else {
                    Image(systemName: "camera.macro.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                        .foregroundColor(ZColor.foreground)
                }

                Text(vm.product.name!)
            }
        }
        .navigationTitle(vm.product.name!)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(coreDataService: CoreDataService())
    }
}
