import SwiftUI

@main
struct PasswordKeeperApp: App {
    var body: some Scene {
        WindowGroup {
            PasswordListView()
                .frame(minWidth: 800, minHeight: 600)
        }
    }
}
