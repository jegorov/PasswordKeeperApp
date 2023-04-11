import SwiftUI

@main
struct PasswordKeeperApp: App {
    var body: some Scene {
        WindowGroup {
            PasswordListView()
        }
        .commands {
            CommandGroup(replacing: .newItem, addition: {
                Button("Open Passwords Storage") {
                    if let fileURL = PasswordStorage.getPasswordsFileURL() {
                        NSWorkspace.shared.open(fileURL)
                    }
                }
            })
        }
    }
}
