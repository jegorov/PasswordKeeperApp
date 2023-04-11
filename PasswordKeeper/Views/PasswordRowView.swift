import SwiftUI

struct PasswordRowView: View {
    let passwordItem: PasswordItem

    var body: some View {
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
    }
}
