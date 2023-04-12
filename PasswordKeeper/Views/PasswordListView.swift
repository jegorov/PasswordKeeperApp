import SwiftUI

struct PasswordListView: View {
    @State private var passwords: [PasswordItem] = []
    @State private var searchText: String = ""
    @State private var selectedPasswords: Set<UUID> = []
    @State private var showingAddPasswordView = false
    @State private var showingDeleteConfirmation = false
    @State private var selection: Int? = nil

    private var selectedCount: Int {
        return selectedPasswords.count
    }

    var body: some View {
        VStack {
            VStack {
                HStack {
                    SearchBar(text: $searchText)
                        .padding(7)
                        .cornerRadius(8)
                        .padding(.horizontal, 10)

                    Spacer()

                    Button(action: {
                        showingAddPasswordView.toggle()
                    }) {
                        Label("Add", systemImage: "plus")
                    }
                    .sheet(isPresented: $showingAddPasswordView) {
                        AddPasswordView(passwords: $passwords)
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
                    ForEach(passwords.filter { searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased()) }) { password in
                        PasswordRowView(passwordItem: password, isSelected: isSelectedBinding(for: password))
                    }
                }
                .onAppear {
                    loadPasswords()
                }
            }
            Spacer()
            HStack {
                Spacer()

                Button("Regenerate UUIDs") {
                    regenerateUUIDs()
                }
                .padding()
            }
        }
        .frame(minWidth: 800, minHeight: 600)
        .alert(isPresented: $showingDeleteConfirmation) {
            Alert(title: Text("Are you sure you want to delete these passwords?"), message: Text("You are about to delete \(selectedCount) password(s). This action cannot be undone."), primaryButton: .destructive(Text("Delete"), action: deleteSelectedPasswords), secondaryButton: .cancel())
        }
    }

    private func isSelectedBinding(for password: PasswordItem) -> Binding<Bool> {
        Binding<Bool> (
            get: { selectedPasswords.contains(password.id) },
            set: { isOn in
                if isOn {
                    selectedPasswords.insert(password.id)
                } else {
                    selectedPasswords.remove(password.id)
                }
            }
        )
    }

    private func loadPasswords() {
        if let loadedPasswords = Storage.load(StorageType.passwords) as [PasswordItem]? {
            passwords = loadedPasswords
        }
    }

    private func regenerateUUIDs() {
        var updatedPasswords = passwords.map { (password) -> PasswordItem in
            PasswordItem(id: UUID(), name: password.name, login: password.login, password: password.password)
        }
        Storage.save(updatedPasswords, for: StorageType.passwords)
        passwords = updatedPasswords
        selectedPasswords = []
    }

    private func deleteSelectedPasswords() {
        passwords = passwords.filter { !selectedPasswords.contains($0.id) }
        selectedPasswords.removeAll()
        Storage.save(passwords, for: StorageType.passwords)
    }
}
