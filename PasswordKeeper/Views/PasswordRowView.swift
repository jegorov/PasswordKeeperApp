import SwiftUI
import AppKit

struct PasswordRowView: View {
    let passwordItem: PasswordItem
    @Binding var isSelected: Bool

    var body: some View {
        HStack {
            Toggle("", isOn: $isSelected)
                .toggleStyle(CheckboxToggleStyle())
                .frame(width: 50)
                .padding(10)

            VStack(alignment: .leading) {
                Text(passwordItem.name)
                    .font(.headline)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Login:")
                        HStack {
                            Text(passwordItem.login)
                                .foregroundColor(.blue)
                            Button(action: {
                                let pasteboard = NSPasteboard.general
                                pasteboard.declareTypes([.string], owner: nil)
                                pasteboard.setString(passwordItem.login, forType: .string)
                            }) {
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                    .padding(.trailing, 10)
                    .background(Color.clear.overlay(Rectangle().stroke(Color.clear, lineWidth: 1).frame(width: nil, height: nil).padding(.trailing, -1)))
                    .overlay(Rectangle().stroke(Color.gray.opacity(0.5), lineWidth: 1).frame(width: 1, height: nil).padding(.trailing, -1), alignment: .trailing)

                    VStack(alignment: .leading) {
                        Text("Password:")
                        HStack {
                            Text(passwordItem.password)
                                .foregroundColor(.blue)
                            Button(action: {
                                let pasteboard = NSPasteboard.general
                                pasteboard.declareTypes([.string], owner: nil)
                                pasteboard.setString(passwordItem.password, forType: .string)
                            }) {
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(.bottom, 10)
        .overlay(Rectangle().stroke(Color.gray.opacity(0.5), lineWidth: 1).frame(width: nil, height: 1).padding(.top, -1), alignment: .bottom)
    }
}
