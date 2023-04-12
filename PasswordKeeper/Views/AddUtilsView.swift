import SwiftUI

struct AddUtilsView: View {
    @Binding var utils: [UtilsItem]

    @State private var value: String = ""
    @State private var description: String = ""


    @Environment(\.presentationMode) var presentationMode

    private func saveUtility() {
        let newUtility = UtilsItem(id: UUID(), value: value, description: description)
        utils.append(newUtility)
        
        Storage.save(utils, for: StorageType.utils)

    }

    var body: some View {
        VStack {
            TextField("Value", text: $value)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Description", text: $description)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()

                Spacer()

                Button("Save") {
                    saveUtility()
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .disabled(value.isEmpty || description.isEmpty)
            }
            .padding()
        }
        .padding()
        .frame(minWidth: 400, minHeight: 300)
    }
}

struct AddUtilsView_Previews: PreviewProvider {
    static var previews: some View {
        AddUtilsView(utils: .constant([]))
    }
}
