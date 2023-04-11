//
//  AddPasswordView.swift
//  PasswordKeeper
//
//  Created by Jegor on 11.04.2023.
//

import Foundation
import SwiftUI

struct AddPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var passwords: [PasswordItem]
    
    @State private var name: String = ""
    @State private var login: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Name", text: $name)
                TextField("Login", text: $login)
                SecureField("Password", text: $password)
            }.padding()
            
            Button(action: {
                let passwordItem = PasswordItem(id: UUID(), name: name, login: login, password: password)
                passwords.append(passwordItem)
                JSONFileManager.shared.save(passwords: passwords)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
            }.padding()
            
            Spacer()
        }
    }
}
