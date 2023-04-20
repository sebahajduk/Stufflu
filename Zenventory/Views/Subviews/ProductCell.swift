//
//  SwiftUIView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 03/04/2023.
//

import SwiftUI

struct ProductCell: View {

    @State var productEntity: ProductEntity

    var body: some View {
        HStack {
            Image(systemName: "camera.macro.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding()
                .foregroundColor(ZColor.foreground)

            VStack(alignment: .leading) {
                Text(productEntity.name ?? "")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(ZColor.foreground)

                Text("Last used: ")
                    .font(.caption2)
                    .foregroundColor(.gray)

                Text(productEntity.productDescr ?? "")
                    .font(.system(size: 10))
                    .padding(.top, 5)
                    .padding(.trailing, 50)
                    .foregroundColor(ZColor.foreground)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(ZColor.background)
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
