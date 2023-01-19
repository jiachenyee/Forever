//
//  Forever+Combine.swift
//  Forever
//
//  Created by Jia Chen Yee on 20/1/23.
//

import Foundation
import Combine

extension Forever: Publisher {
    public typealias Output = Value
    public typealias Failure = Never
    
    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Value == S.Input {
        combineAdapter.subscriber = subscriber
    }
    
    class CombineAdapter<Value: Codable> {
        var subscriber: (any Subscriber<Value, Never>)? = nil
        
        @discardableResult func update(with value: Value) -> Subscribers.Demand? {
            subscriber?.receive(value)
        }
    }
}
