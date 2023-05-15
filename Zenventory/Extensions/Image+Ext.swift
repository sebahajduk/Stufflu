//
//  Image+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 08/05/2023.
//

import SwiftUI

extension Image {
    func circleImage(
        size: CGFloat,
        action: Bool
    ) -> some View {
        self
            .resizable()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .padding()
            .foregroundColor(action ? .actionColor() : .foregroundColor())
    }
}

