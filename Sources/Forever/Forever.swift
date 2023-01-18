//
//  Forever.swift
//  Forever
//
//  Created by Jia Chen Yee on 18/1/23.
//

import Foundation
import SwiftUI

@frozen @propertyWrapper public struct Forever<Value: Codable>: DynamicProperty {
    
    public var key: String
    
    @State private var value: Value
        
    public var wrappedValue: Value {
        get {
            return value
        }
        nonmutating set {
            value = newValue
            save(value: newValue)
        }
    }
    
    public init(wrappedValue: Value, _ key: String) {
        self.key = key
        
        let archiveURL = Self.getArchiveURL(from: key)
        
        let propertyListDecoder = JSONDecoder()
        
        if let retrievedValueData = try? Data(contentsOf: archiveURL),
           let decodedValue = try? propertyListDecoder.decode(Value.self, from: retrievedValueData) {
            _value = State(wrappedValue: decodedValue)
        } else {
            _value = State(wrappedValue: wrappedValue)
        }
    }
    
    static func getArchiveURL(from key: String) -> URL {
        let plistName = "\(key).plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(plistName)
        
        return documentsDirectory
    }
    
    func save(value: Value) {
        let archiveURL = Self.getArchiveURL(from: key)
        let propertyListEncoder = JSONEncoder()
        let encodedValue = try? propertyListEncoder.encode(value)
        try? encodedValue?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func getValue() -> Value? {
        let archiveURL = Self.getArchiveURL(from: key)
        let propertyListDecoder = JSONDecoder()
        
        if let retrievedValueData = try? Data(contentsOf: archiveURL),
           let decodedValue = try? propertyListDecoder.decode(Value.self, from: retrievedValueData) {
            return decodedValue
        }
        return nil
    }
}
