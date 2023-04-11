import Foundation

struct PasswordStorage {
    static private let passwordJsonFileName = "passwords.json"

    static func loadPasswords() -> [PasswordItem] {
        let fileURL = getDocumentsDirectory().appendingPathComponent(passwordJsonFileName)

        if let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()

            if let passwords = try? decoder.decode([PasswordItem].self, from: data) {
                return passwords
            }
        }

        return []
    }

    static func savePasswords(_ passwords: [PasswordItem]) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(passwordJsonFileName)
        let encoder = JSONEncoder()

        if let data = try? encoder.encode(passwords) {
            try? data.write(to: fileURL)
        }
    }

    static private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
