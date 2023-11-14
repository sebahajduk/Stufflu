//
//  PriceTextField.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 08/05/2023.
//

import SwiftUI

struct PriceTextField: ViewModifier {
    func body(
        content: Content
    ) -> some View {
        content
            .frame(height: 30.0)
            .frame(maxWidth: 60.0)
            .padding(.horizontal, 25.0)
            .background(.ultraThickMaterial)
            .cornerRadius(8.0)
            .padding(.horizontal, 10.0)
    }
}
