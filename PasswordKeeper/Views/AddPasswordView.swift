import SwiftUI

struct AddPasswordView: View {
    @Binding var passwords: [PasswordItem]

    @State private var name: String = ""
    @State private var login: String = ""
    @State private var password: String = ""

    @Environment(\.presentationMode) var presentationMode

    private func savePassword() {
        let newPassword = PasswordItem(id: UUID(), name: name, login: login, password: password)
        passwords.append(newPassword)
        
        Storage.save(passwords, for: StorageType.passwords)
    }

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Login", text: $login)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()

                Spacer()

                Button("Save") {
                    savePassword()
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .disabled(name.isEmpty || login.isEmpty || password.isEmpty)
            }
            .padding()
        }
        .padding()
        .frame(minWidth: 400, minHeight: 300)

    }
}

struct AddPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        AddPasswordView(passwords: .constant([]))
    }
}
