//
//  PriceTextField.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 08/05/2023.
//

import SwiftUI

internal struct PriceTextField: ViewModifier {
    internal func body(content: Content) -> some View {
        content
            .frame(height: 30)
            .frame(maxWidth: 60)
            .padding(.horizontal, 25)
            .background(.ultraThickMaterial)
            .cornerRadius(8)
            .padding(.horizontal, 10)
    }
}
