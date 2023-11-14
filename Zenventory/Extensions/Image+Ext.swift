//
//  Image+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 08/05/2023.
//

import SwiftUI

extension Image {
    func roundedImage(
        size: CGFloat,
        action: Bool
    ) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .padding()
            .foregroundColor(action ? .actionColor() : .foregroundColor().opacity(0.3))
    }
}
