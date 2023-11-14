//
//  StandardButton.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 11/04/2023.
//

import SwiftUI

struct StandardButton: ButtonStyle {
    func makeBody(
        configuration: Configuration
    ) -> some View {
            configuration.label
            .padding(.vertical, 10.0)
            .padding(.horizontal, 20.0)
                .bold()
                .background(Color.actionColor())
                .foregroundColor(.backgroundColor())
                .clipShape(Capsule())
                .opacity(configuration.isPressed ? 0.9 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}
