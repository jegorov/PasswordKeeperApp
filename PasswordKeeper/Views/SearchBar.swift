import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isFocused: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.controlBackgroundColor))
                .overlay(RoundedRectangle(cornerRadius: 18).stroke(isFocused ? Color(.controlAccentColor) : Color(.separatorColor), lineWidth: 1))
                .frame(height: 30)
                .onTapGesture {
                    isFocused = true
                }

            HStack {
                TextField("Search", text: $text, onEditingChanged: { editing in
                    isFocused = editing
                })
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                    .frame(height: 30)
                    .background(Color.clear)
                    .textFieldStyle(PlainTextFieldStyle())
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
