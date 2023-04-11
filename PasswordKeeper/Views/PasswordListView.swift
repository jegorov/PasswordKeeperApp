import SwiftUI

struct PasswordListView: View {
    @State private var passwords: [PasswordItem] = JSONFileManager.shared.load()
    @State private var searchText: String = ""
    @State private var showingAddPasswordView = false
    @State private var showingDeleteConfirmation = false
    @State private var selectedPasswords: Set<UUID> = Set()
    
    private var selectedCount: Int {
        return selectedPasswords.count
    }

    private var filteredPasswords: [PasswordItem] {
        return passwords.filter { searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Password Keeper")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
            }
            
            HStack {
                TextField("Search", text: $searchText)
                    .padding(7)
//                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                
                Spacer()
                
                Button(action: {
                    showingAddPasswordView.toggle()
                }) {
                    Label("Add", systemImage: "plus")
                }
                
                if selectedCount > 0 {
                    Button(action: {
                        showingDeleteConfirmation.toggle()
                    }) {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }.padding()
            
            List {
                ForEach(filteredPasswords) { passwordItem in
                    PasswordRowView(passwordItem: passwordItem, isSelected: isSelected(id: passwordItem.id))
                }
            }
            
            Spacer()
        }
        .frame(minWidth: 800, minHeight: 600)
        .alert(isPresented: $showingDeleteConfirmation) {
            Alert(title: Text("Are you sure you want to delete these passwords?"), message: Text("You are about to delete \(selectedCount) password(s). This action cannot be undone."), primaryButton: .destructive(Text("Delete"), action: deletePasswords), secondaryButton: .cancel())
        }
        .sheet(isPresented: $showingAddPasswordView) {
            AddPasswordView(passwords: $passwords)
        }
    }

    private func isSelected(id: UUID) -> Binding<Bool> {
        Binding<Bool>(
            get: { selectedPasswords.contains(id) },
            set: { isSelected in
                if isSelected {
                    selectedPasswords.insert(id)
                } else {
                    selectedPasswords.remove(id)
                }
            }
        )
    }

    private func deletePasswords() {
        passwords.removeAll { passwordItem in
            selectedPasswords.contains(passwordItem.id)
        }
        selectedPasswords.removeAll()
        JSONFileManager.shared.save(passwords: passwords)
    }
}
