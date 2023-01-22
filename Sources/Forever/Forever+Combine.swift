//
//  Forever+Combine.swift
//  Forever
//
//  Created by Jia Chen Yee on 20/1/23.
//

import Foundation
import Combine

extension Forever {
    public var publisher: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
}
