import SwiftUI

struct AddPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var passwords: [PasswordItem]
    
    @State private var name: String = ""
    @State private var login: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Add Password")
                .font(.largeTitle)
                .padding()

            Form {
                TextField("Name", text: $name)
                TextField("Login", text: $login)
                SecureField("Password", text: $password)
            }
            .padding()

            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }

                Spacer()

                Button("Save") {
                    let newItem = PasswordItem(id: UUID(), name: name, login: login, password: password)
                    passwords.append(newItem)
                    JSONFileManager.shared.save(passwords: passwords)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(name.isEmpty || login.isEmpty || password.isEmpty)
            }
            .padding()
        }
        .padding()
        .frame(minWidth: 400, minHeight: 300)
    }
}
