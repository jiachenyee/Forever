//
//  Forever+Combine.swift
//  Forever
//
//  Created by Jia Chen Yee on 20/1/23.
//

import Foundation
import Combine

extension Forever {
    /// A [Combine](http://developer.apple.com/documentation/combine) publisher that publishes the result of the variable whenever it changes.
    ///
    /// In the following example, you can integrate `Forever` as part of your UIKit app to create a simple clicker.
    /// ```swift
    ///class ViewController: UIViewController {
    ///
    ///    @Forever("counter") var counter = 1
    ///
    ///    @IBOutlet weak var counterLabel: UILabel!
    ///
    ///    var cancellables = Set<AnyCancellable>()
    ///
    ///    override func viewDidLoad() {
    ///        super.viewDidLoad()
    ///
    ///        // When `counter` is updated, update the `counterLabel`'s value
    ///        _counter.publisher
    ///            .map(\.description)
    ///            .assign(to: \.text!, on: counterLabel)
    ///            .store(in: &cancellables)
    ///    }
    ///
    ///    @IBAction func onClick(_ sender: Any) {
    ///        counter += 1
    ///    }
    ///}
    /// ```
    public var publisher: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
}
