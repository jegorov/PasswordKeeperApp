import SwiftUI

struct UtilsView: View {
    @State private var utils: [UtilsItem] = []
    @State private var searchText: String = ""
    @State private var selectedUtils: Set<UUID> = []
    @State private var showingAddUtilsView = false
    @State private var showingDeleteConfirmation = false

    private var selectedCount: Int {
        return selectedUtils.count
    }

    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $searchText)
                    .padding(7)
                    .cornerRadius(8)
                    .padding(.horizontal, 10)

                Spacer()

                Button(action: {
                    showingAddUtilsView.toggle()
                }) {
                    Label("Add", systemImage: "plus")
                }
                .sheet(isPresented: $showingAddUtilsView) {
                    AddUtilsView(utils: $utils)
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
                ForEach(utils.filter { searchText.isEmpty || $0.description.lowercased().contains(searchText.lowercased()) || $0.value.lowercased().contains(searchText.lowercased()) }) { util in
                    UtilsRowView(utilsItem: util, isSelected: isSelectedBinding(for: util))
                }
            }.onAppear {
                loadUtils()
            }


            Spacer()

            HStack {
                           Spacer()

                           Button("Regenerate UUIDs") {
                               regenerateUUIDs()
                           }
                           .padding()
                       }
                       .padding()
        }
        .frame(minWidth: 800, minHeight: 600)
        .alert(isPresented: $showingDeleteConfirmation) {
            Alert(title: Text("Are you sure you want to delete these items?"),
                  message: Text("You are about to delete \(selectedCount) item(s). This action cannot be undone."),
                  primaryButton: .destructive(Text("Delete"), action: deleteSelectedUtils),
                  secondaryButton: .cancel())
        }
    }

    private func isSelectedBinding(for util: UtilsItem) -> Binding<Bool> {
        Binding<Bool> (
            get: { selectedUtils.contains(util.id) },
            set: { isOn in
                if isOn {
                    selectedUtils.insert(util.id)
                } else {
                    selectedUtils.remove(util.id)
                }
            }
        )
    }
    
    private func loadUtils() {
           if let loadedUtils = Storage.load(StorageType.utils) as [UtilsItem]? {
               utils = loadedUtils
           }
       }
    

    private func deleteSelectedUtils() {
        utils = utils.filter { !selectedUtils.contains($0.id) }
        selectedUtils.removeAll()
        
        Storage.save(utils, for: StorageType.utils)

    }
    
    private func regenerateUUIDs() {
            var updatedUtils = utils.map { (util) -> UtilsItem in
                UtilsItem(id: UUID(), value: util.value, description: util.description)
            }
            Storage.save(updatedUtils, for: .utils)
            utils = updatedUtils
            selectedUtils = []
        }
}
