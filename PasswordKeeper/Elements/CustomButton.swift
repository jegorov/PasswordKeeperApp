//
//  CustomTextField.swift
//  PasswordKeeper
//
//  Created by Jegor on 12.04.2023.
//

import Foundation
import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let label: String
    let backgroundColor: Color
    let isDisabled: Bool

    var body: some View {
        Button(action: action) {
            Text(label)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled)
    }
}
