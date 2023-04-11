import SwiftUI

struct PasswordRowView: View {
    let passwordItem: PasswordItem
    @Binding var isSelected: Bool

    var body: some View {
        HStack {
            Toggle("", isOn: $isSelected)
                .toggleStyle(CheckboxToggleStyle())
                .padding(10)
                .frame(width: 50)
            Spacer()

            VStack(alignment: .leading) {
                Text(passwordItem.name)
                    .font(.headline)
                HStack {
                    Text("Login: \(passwordItem.login)")
                    Spacer()
                    Text("Password: \(passwordItem.password)")
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }

            Spacer()
        }
    }
}
