import Foundation

class JSONFileManager {
    static let shared = JSONFileManager()
    
    private init() {}
    
    private let fileName = "passwords.json"

    func load() -> [PasswordItem] {
        let fileURL = getApplicationSupportDirectory().appendingPathComponent(fileName)

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let passwords = try decoder.decode([PasswordItem].self, from: data)
            return passwords
        } catch {
            print("Error loading passwords: \(error)")
            return []
        }
    }
    
    func save(passwords: [PasswordItem]) {
        let fileURL = getApplicationSupportDirectory().appendingPathComponent(fileName)

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(passwords)
            try data.write(to: fileURL)
        } catch {
            print("Error saving passwords: \(error)")
        }
    }
    
    private func getApplicationSupportDirectory() -> URL {
        let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        print("Current directory: \(url.path)")

        let appSupportSubfolder = url.appendingPathComponent(Bundle.main.bundleIdentifier!, isDirectory: true)
        
        do {
            try FileManager.default.createDirectory(at: appSupportSubfolder, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating application support subdirectory: \(error)")
        }
        
        return appSupportSubfolder
    }
}
