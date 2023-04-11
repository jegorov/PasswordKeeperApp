import SwiftUI

struct PasswordListView: View {
    @State private var passwords: [PasswordItem] = JSONFileManager.shared.load()
    @State private var searchText: String = ""
    @State private var showingAddPasswordView = false
    
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
                    .background(Color(NSColor.gray.cgColor))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                
                Spacer()
                
                Button(action: {
                    showingAddPasswordView.toggle()
                }) {
                    Label("Add", systemImage: "plus")
                }
            }.padding()
            
            List {
                ForEach(passwords.filter { searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased()) }) { passwordItem in
                    PasswordRowView(passwordItem: passwordItem)
                }
            }
            
            Spacer()
        }
        .frame(minWidth: 800, minHeight: 600)
        .sheet(isPresented: $showingAddPasswordView) {
            AddPasswordView(passwords: $passwords)
        }
    }
}
