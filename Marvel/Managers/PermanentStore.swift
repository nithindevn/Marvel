//
//  PermanentStore.swift
//  Marvel
//
//  Created by nithindev.narayanan on 10/12/20.
//

import Foundation

protocol PersistableCharacter {
    
    @discardableResult func saveCharactersToFile(_ characters: [String]) -> Bool
    func readCharactersFromFile() -> [String]
}

class PermanentStore {
    
    private struct StoreConfig {

        static let modelPathComponent = "marvel.plist"
        static let character = "character"

    }
    
    private lazy var applicationDirectory: URL = {

        // The directory the application uses to store store information file.
        // This code uses a directory named after the bundle identifier in the application's documents Application Support directory.
        let storageDirectoryURL: URL
        let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)

        try? FileManager.default.createDirectory(at: urls[urls.count - 1], withIntermediateDirectories: true, attributes: nil)
        storageDirectoryURL = urls[urls.count - 1]

        return storageDirectoryURL
    }()

    @discardableResult private func fileRepresentation(filePathComponent: String = StoreConfig.modelPathComponent) -> (NSMutableDictionary?, String) {

        let fileURL = applicationDirectory.appendingPathComponent(filePathComponent)
        let filePath = fileURL.path

        //exclude this file from iCloud automatic backups
        let fileValuesOption = [URLResourceKey.isExcludedFromBackupKey: true]
        try? (fileURL as NSURL).setResourceValues(fileValuesOption)

        //add file protection attributes
        let fileAttributes: [FileAttributeKey: Any] = [FileAttributeKey.protectionKey: FileProtectionType.complete]
        try? FileManager.default.setAttributes(fileAttributes, ofItemAtPath: filePath)

        //create file manager
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: filePath) {

            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: [String: Any](), requiringSecureCoding: false)
                fileManager.createFile(atPath: filePath, contents: data, attributes: fileAttributes)
                //clean file
                let file = NSMutableDictionary(contentsOfFile: filePath)
                file?.removeAllObjects()
                file?.write(toFile: filePath, atomically: true)
            } catch {
                print("Couldn't Write")
            }
        }

        return (NSMutableDictionary(contentsOfFile: filePath), filePath)
    }
    
    
}

extension PermanentStore: PersistableCharacter {
    
    @discardableResult func saveCharactersToFile(_ characters: [String]) -> Bool {
        
        let (file, path) = fileRepresentation()

        if let characterData = try? JSONEncoder().encode(characters) {

            file?.setValue(characterData, forKey: StoreConfig.character)
            guard let success = file?.write(toFile: path, atomically: true) else { return false }
            return success
        }

        return false
    }
    
    func readCharactersFromFile() -> [String] {
        
        let (file, _) = fileRepresentation()

        if let characterData = file?.value(forKey: StoreConfig.character) as? Data {

            let decoder = JSONDecoder()
            do {

                let savedCharacters = try decoder.decode([String].self, from: characterData)
                return savedCharacters
            } catch {

                return []
            }
        }

        return []
    }
}
