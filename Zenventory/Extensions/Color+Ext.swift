//
//  Color+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 21/03/2023.
//

import SwiftUI

extension Color {

    internal static func backgroundColor() -> Color {
        .init("background")
    }

    internal static func foregroundColor() -> Color {
        .init("foreground")
    }

    internal static func actionColor() -> Color {
        .init("action")
    }
}
