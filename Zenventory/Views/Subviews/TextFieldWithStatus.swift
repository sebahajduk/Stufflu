//
//  TextFieldWithStatus.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 17/04/2023.
//

import SwiftUI

internal struct TextFieldWithStatus: View {

    @Binding internal var isValid: Bool
    @Binding internal var textFieldValue: String
    @State internal var textFieldLabel: String = ""
    @State internal var keyboardType: UIKeyboardType

    var body: some View {
        HStack {
            TextField(textFieldLabel, text: $textFieldValue)
                .keyboardType(keyboardType)

            if isValid {
                Image(systemName: "checkmark.circle.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.green)
            } else {
                Image(systemName: "x.circle.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.red)
            }
        }
    }

}
