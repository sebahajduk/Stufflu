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
        SButton(configuration: configuration)
    }

    struct SButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool

        var body: some View {
            configuration.label
            .padding(.vertical, 10.0)
            .padding(.horizontal, 20.0)
                .bold()
                .background(backgroundColor)
                .foregroundColor(.backgroundColor())
                .clipShape(Capsule())
                .opacity(configuration.isPressed ? 0.9 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
        }

        var backgroundColor: Color {
            if isEnabled {
                return Color.actionColor()
            } else {
                return Color.gray.opacity(0.5)
            }
        }
    }
}
