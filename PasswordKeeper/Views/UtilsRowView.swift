import SwiftUI
import AppKit

struct UtilsRowView: View {
    let utilsItem: UtilsItem
    @Binding var isSelected: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            Toggle("", isOn: $isSelected)
                .toggleStyle(CheckboxToggleStyle())
                .frame(width: 50)
                .padding(10)

            VStack(alignment: .leading) {
            
            Text(utilsItem.description)
                    .bold()
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.trailing, 10)
                    .background(Color.clear.overlay(Rectangle().stroke(Color.clear, lineWidth: 1).frame(width: nil, height: nil).padding(.trailing, -1)))
                    .overlay(Rectangle().stroke(Color.gray.opacity(0.5), lineWidth: 1).frame(width: 1, height: nil).padding(.trailing, -1), alignment: .trailing)
            }
            .padding(.trailing, 10)

            HStack {
                Text("Value:")
                    .bold()
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                Text(utilsItem.value)
                    .italic()
                    .foregroundColor(.blue)
                Button(action: {
                    let pasteboard = NSPasteboard.general
                    pasteboard.declareTypes([.string], owner: nil)
                    pasteboard.setString(utilsItem.value, forType: .string)
                }) {
                    Image(systemName: "doc.on.doc")
                        .foregroundColor(.gray)
                        .font(.system(size: 10))
                }
                .buttonStyle(BorderlessButtonStyle())
            }

            Spacer()
        }
        .padding(.bottom, 10)
        .overlay(Rectangle().stroke(Color.gray.opacity(0.5), lineWidth: 1).frame(width: nil, height: 1).padding(.top, -1), alignment: .bottom)
    }
}
