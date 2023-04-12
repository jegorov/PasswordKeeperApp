//
//  CustomTextField.swift
//  PasswordKeeper
//
//  Created by Jegor on 12.04.2023.
//

import Foundation
import SwiftUI



struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String

    @Environment(\.colorScheme) var colorScheme
    @FocusState private var isFocused: Bool

    var body: some View {
        TextField(placeholder, text: $text)
            .focused($isFocused)
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8)
                            .fill(colorScheme == .dark ? Color(white: 0.2) : Color(white: 0.95))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isFocused ? Color.blue : Color.gray, lineWidth: 1)
                            )
            )
            .disableAutocorrection(true)
            .textFieldStyle(PlainTextFieldStyle())
    }
}



