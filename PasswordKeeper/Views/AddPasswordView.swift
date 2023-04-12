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
                CustomTextField(placeholder: "Name", text: $name)
                    .padding()

                CustomTextField(placeholder: "Login", text: $login)
                    .padding()

                CustomTextField(placeholder: "Password", text: $password)
                    .padding()

                HStack {
                    CustomButton(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: "Cancel", backgroundColor: Color.gray, isDisabled : false)

                    CustomButton(action: {
                        savePassword()
                        presentationMode.wrappedValue.dismiss()
                    }, label: "Save", backgroundColor: (name.isEmpty || login.isEmpty || password.isEmpty ? Color.gray.opacity(0.5) : Color.blue), isDisabled: (name.isEmpty || login.isEmpty || password.isEmpty))
                }
                .padding()
            }
            .padding()
            .frame(minWidth: 400, minHeight: 300)
        }
    }

    struct AdaptiveTextFieldStyle: TextFieldStyle {
        @Environment(\.colorScheme) var colorScheme

        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(8)
                .background(colorScheme == .dark ? Color(white: 0.2) : Color(white: 0.95))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }

    struct AddPasswordView_Previews: PreviewProvider {
        static var previews: some View {
            AddPasswordView(passwords: .constant([]))
        }
    }
