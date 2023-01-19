//
//  Forever+Persistence.swift
//  Forever
//
//  Created by Jia Chen Yee on 20/1/23.
//

import Foundation

extension Forever {
    func getArchiveURL(from key: String) -> URL {
        let plistName = "\(key).plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(plistName)
        
        return documentsDirectory
    }
    
    func save(value: Value) {
        combineAdapter.update(with: value)
        
        let archiveURL = getArchiveURL(from: key)
        let propertyListEncoder = JSONEncoder()
        let encodedValue = try? propertyListEncoder.encode(value)
        try? encodedValue?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func getValue() -> Value? {
        let archiveURL = getArchiveURL(from: key)
        let propertyListDecoder = JSONDecoder()
        
        if let retrievedValueData = try? Data(contentsOf: archiveURL),
           let decodedValue = try? propertyListDecoder.decode(Value.self, from: retrievedValueData) {
            return decodedValue
        }
        return nil
    }
}
