//
//  RemoveFocusOnTapModifier.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 10/06/2023.
//

import SwiftUI

internal struct RemoveFocusOnTapModifier: ViewModifier {
    internal func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}
