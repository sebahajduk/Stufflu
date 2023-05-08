//
//  ProductDetailsView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/05/2023.
//

import SwiftUI

internal struct ProductDetailsView: View {

    @StateObject var vm: ProductDetailsVM

    internal init(
        product: ProductEntity
    ) {
        _vm = StateObject(wrappedValue: ProductDetailsVM(product: product))
    }

    var body: some View {
        ZStack {
            ZColor.background
                .ignoresSafeArea()

            VStack(alignment: .center) {
                if vm.image != nil {
                    Image(uiImage: vm.image!)
                        .circleImage(size: 100, action: true)
                } else {
                    Image(systemName: "camera.macro.circle.fill")
                        .circleImage(size: 100, action: true)
                }
            }
        }
        .navigationTitle(vm.product.name!)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(coreDataService: CoreDataService())
    }
}