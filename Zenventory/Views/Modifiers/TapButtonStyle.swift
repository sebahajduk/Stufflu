//
//  TapButtonStyle.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 10/08/2023.
//

import SwiftUI

struct TapButtonStyle: ButtonStyle {
    func makeBody(
        configuration: Configuration
    ) -> some View {
        configuration
            .label
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}
