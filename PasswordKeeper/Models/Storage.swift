import Foundation

enum StorageType {
    case passwords
    case utils

    var fileName: String {
        switch self {
        case .passwords:
            return "passwords"
        case .utils:
            return "utils"
        }
    }

    var fileExtension: String {
        return "json"
    }
}

struct Storage {
    
    static func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func getFileURL(for storageType: StorageType) -> URL? {
            let fileName = storageType.fileName
            let fileExtension = storageType.fileExtension

            return getDocumentDirectory().appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        }

    static func load<T: Decodable>(_ type: StorageType) -> [T]? {
        guard let url = getFileURL(for: type) else {
                  print("Failed to get file URL")
                  return nil
              }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let items = try decoder.decode([T].self, from: data)
            return items
        } catch {
            print("Failed to decode the JSON file: \(error.localizedDescription)")
            return nil
        }
    }

    static func save<T: Encodable>(_ items: [T], for type: StorageType) {
        guard let url = getFileURL(for: type) else {
                  print("Failed to get file URL")
                  return
              }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(items)
            try data.write(to: url)
        } catch {
            print("Failed to encode and save the JSON file: \(error.localizedDescription)")
        }
    }
}
