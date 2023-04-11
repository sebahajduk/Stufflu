//
//  SwiftUIView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 03/04/2023.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        HStack {
            Image(systemName: "camera.macro.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding()

            VStack(alignment: .leading) {
                Text("Product name")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(ZColor.foreground)

                Text("Last used: 02.04.2023")
                    .font(.caption2)

                Text("Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum")
                    .font(.system(size: 10))
                    .padding(.top, 5)
                    .padding(.trailing, 50)
            }

        }
        .padding()
        .frame(maxHeight: 100)
        .background(.gray.opacity(0.2))
        .cornerRadius(30)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
