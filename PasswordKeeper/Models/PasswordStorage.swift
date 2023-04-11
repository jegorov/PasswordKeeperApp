import Foundation

struct PasswordStorage {
    
    static let fileName = "passwords"
    static let fileExtension = "json"

    static func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    static func loadPasswords() -> [PasswordItem]? {
        let url = getDocumentDirectory().appendingPathComponent(fileName).appendingPathExtension(fileExtension)

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let passwords = try decoder.decode([PasswordItem].self, from: data)
            return passwords
        } catch {
            print("Failed to decode the JSON file: \(error.localizedDescription)")
            return nil
        }
    }

    static func savePasswords(_ passwords: [PasswordItem]) {
        let url = getDocumentDirectory().appendingPathComponent(fileName).appendingPathExtension(fileExtension)

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(passwords)
            try data.write(to: url)
        } catch {
            print("Failed to encode and save the JSON file: \(error.localizedDescription)")
        }
    }
}
