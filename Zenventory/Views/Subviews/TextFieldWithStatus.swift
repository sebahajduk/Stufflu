//
//  TextFieldWithStatus.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 17/04/2023.
//

import SwiftUI

struct TextFieldWithStatus: View {

    @Binding var isValid: Bool
    @Binding var textFieldValue: String
    @State var textFieldLabel: String = ""
    @State var keyboardType: UIKeyboardType

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
