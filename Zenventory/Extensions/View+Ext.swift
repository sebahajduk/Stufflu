//
//  View+Ext.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 10/06/2023.
//

import SwiftUI

extension View {
    func removeFocusOnTap() -> some View {
        modifier(RemoveFocusOnTapModifier())
    }
}
