//
//  StandardButton.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 11/04/2023.
//

import SwiftUI

struct StandardButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .bold()
                .background(ZColor.foreground)
                .foregroundColor(ZColor.background)
                .clipShape(Capsule())
                .opacity(configuration.isPressed ? 0.9 : 1)
                .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}
