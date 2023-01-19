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
@propertyWrapper public struct Forever<Value: Codable>: DynamicProperty {
    
    var combineAdapter: CombineAdapter<Value>!
    
    public var key: String
    
    @State private var value: Value
    
    public var wrappedValue: Value {
        get {
            return getValue() ?? value
        }
        nonmutating set {
            self.value = newValue
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
    
    public init(wrappedValue: Value, _ key: String, file: String = #file, line: UInt = #line) {
        precondition(!key.isEmpty, "The key cannot be an empty String.\n\(file):\(line)")
        
        self.key = key
        
        _value = State(wrappedValue: wrappedValue)
        
        if let value = getValue() {
            _value = State(wrappedValue: value)
        }
        
        combineAdapter = .init()
    }
}
