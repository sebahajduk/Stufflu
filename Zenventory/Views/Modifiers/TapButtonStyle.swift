//
//  TapButtonStyle.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 10/08/2023.
//

import SwiftUI

internal struct TapButtonStyle: ButtonStyle {
    internal func makeBody(
        configuration: Configuration
    ) -> some View {
        configuration
            .label
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}
