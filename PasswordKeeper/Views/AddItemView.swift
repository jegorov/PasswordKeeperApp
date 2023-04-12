import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var passwordItems: [PasswordItem]
    @Binding var utilsItems: [UtilsItem]
    let itemType: ItemType

    @State private var fields: [String] = []

    var body: some View {
        VStack(spacing: 20) {
            ForEach(0..<itemType.numberOfFields, id: \.self) { index in
                TextField(itemType.fieldName(for: index), text: $fields[index])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Spacer()
            HStack {
                Spacer()
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.trailing)
                Button("Save") {
                    saveItem()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
        }
        .padding()
        .frame(minWidth: 400)
        .onAppear {
            fields = Array(repeating: "", count: itemType.numberOfFields)
        }
    }

    private func saveItem() {
        switch itemType {
        case .password:
            let newItem = PasswordItem(id: UUID(), name: fields[0], login: fields[1], password: fields[2])
            passwordItems.append(newItem)
        case .utils:
            let newItem = UtilsItem(id: UUID(), value: fields[0], description: fields[1])
            utilsItems.append(newItem)
        }

        saveItems()
    }

    private func saveItems() {
        switch itemType {
        case .password:
            let url = Storage.getFileURL(for: itemType.storageType)

            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(passwordItems)
                try? data.write(to: url!)
                
            } catch {
                print("Failed to encode and save the JSON file: \(error.localizedDescription)")
            }
        case .utils:
            let url = Storage.getFileURL(for: itemType.storageType)

            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(utilsItems)
                try? data.write(to: url!)
                
            } catch {
                print("Failed to encode and save the JSON file: \(error.localizedDescription)")
            }
        }
    }
    
    enum ItemType {
        case password
        case utils
        
        var numberOfFields: Int {
            switch self {
            case .password:
                return 3
            case .utils:
                return 2
            }
        }
        
        func fieldName(for index: Int) -> String {
            switch self {
            case .password:
                switch index {
                case 0:
                    return "Name"
                case 1:
                    return "Login"
                case 2:
                    return "Password"
                default:
                    fatalError("Invalid index for password fields.")
                }
            case .utils:
                switch index {
                case 0:
                    return "Description"
                case 1:
                    return "Value"
                default:
                    fatalError("Invalid index for utils fields.")
                }
            }
        }

        var storageType: StorageType {
            switch self {
            case .password:
                return .passwords
            case .utils:
                return .utils
            }
        }
    }

}
