import SwiftUI

@main
struct PasswordKeeperApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .commands {
            CommandGroup(replacing: .newItem, addition: {
                Button("Open Passwords Storage") {
                    if let fileURL = Storage.getFileURL(for: .passwords) {
                        NSWorkspace.shared.open(fileURL)
                    }
                }
                Button("Open Utils Storage") {
                    if let fileURL = Storage.getFileURL(for: .utils) {
                        NSWorkspace.shared.open(fileURL)
                    }
                }
            })
        }
    }
}
