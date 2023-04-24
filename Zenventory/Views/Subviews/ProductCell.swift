//
//  SwiftUIView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 03/04/2023.
//

import SwiftUI

struct ProductCell: View {

    @StateObject private var vm: ProductCellViewModel

    init(productEntity: ProductEntity) {
        _vm = StateObject(wrappedValue: ProductCellViewModel(product: productEntity))
    }

    var body: some View {
        HStack {
            Image(systemName: "camera.macro.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding()
                .foregroundColor(ZColor.foreground)

            VStack(alignment: .leading, spacing: 2) {
                Text(vm.product.name ?? "")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(ZColor.foreground)

                Text("Last used: \(vm.lastUsed)")
                    .font(.caption2)
                    .foregroundColor(.gray)

                Text(vm.product.productDescr ?? "lorem ipsum lorem ipsum lorem ipsum")
                    .font(.system(size: 10))
                    .padding(.top, 5)
                    .padding(.trailing, 50)
                    .foregroundColor(ZColor.foreground)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 90)
        .background(ZColor.background)
        .listRowBackground(ZColor.background)
        .cornerRadius(30)
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.gray.opacity(0.2), lineWidth: 1)
        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(coreDataService: CoreDataService())
    }
}
