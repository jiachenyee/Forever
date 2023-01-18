//
//  Forever.swift
//  Forever
//
//  Created by Jia Chen Yee on 18/1/23.
//

import Foundation
import SwiftUI

public typealias DontDie = Forever
public typealias DontLeaveMe = Forever
public typealias BePersistent = Forever
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
    
    public var projectedValue: Binding<Value> {
        Binding {
            _value.wrappedValue
        } set: { value, transaction in
            
            if transaction.disablesAnimations {
                self.value = value
            } else {
                withAnimation(transaction.animation) {
                    self.value = value
                }
            }
            save(value: value)
        }
    }
    
    public init(wrappedValue: Value, _ key: String,
                file: String = #file, line: UInt = #line) {
        precondition(!key.isEmpty, "The key cannot be an empty String.\n\(file):\(line)")
        
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
    
    private static func getArchiveURL(from key: String) -> URL {
        let plistName = "\(key).plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(plistName)
        
        return documentsDirectory
    }
    
    private func save(value: Value) {
        let archiveURL = Self.getArchiveURL(from: key)
        let propertyListEncoder = JSONEncoder()
        let encodedValue = try? propertyListEncoder.encode(value)
        try? encodedValue?.write(to: archiveURL, options: .noFileProtection)
    }
    
    private func getValue() -> Value? {
        let archiveURL = Self.getArchiveURL(from: key)
        let propertyListDecoder = JSONDecoder()
        
        if let retrievedValueData = try? Data(contentsOf: archiveURL),
           let decodedValue = try? propertyListDecoder.decode(Value.self, from: retrievedValueData) {
            return decodedValue
        }
        return nil
    }
}
