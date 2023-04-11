//
//  PasswordView.swift
//  PasswordKeeper
//
//  Created by Jegor on 11.04.2023.
//

import SwiftUI

struct PasswordView: View {
    
    var body: some View {
        VStack {
            Text("Password Manager")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            HStack {
                Spacer()
                
                Text("Welcome!")
                    .font(.title)
                
                Spacer()
            }
            
            Spacer()
            
            Text("Use the password view controller to manage your passwords.")
            
            Spacer()
        }
        .padding()
    }
}
