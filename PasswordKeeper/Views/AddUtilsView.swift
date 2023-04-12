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
            CustomTextField(placeholder: "Value", text: $value)
                .padding()
            CustomTextField(placeholder: "Description", text: $description)
                .padding()

            HStack {
                CustomButton(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: "Cancel", backgroundColor: Color.gray, isDisabled : false)

                CustomButton(action: {
                    saveUtility()
                    presentationMode.wrappedValue.dismiss()
                }, label: "Save", backgroundColor: (value.isEmpty || description.isEmpty ? Color.gray.opacity(0.5) : Color.blue), isDisabled: (value.isEmpty || description.isEmpty))
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
