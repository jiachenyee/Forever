//
//  Forever.swift
//  Forever
//
//  Created by Jia Chen Yee on 18/1/23.
//

import Foundation
import SwiftUI
import Combine
 
/// Ever wanted to tell a variable to "Don't Die"?
///
/// ```swift
/// @DontDie("counter") var counter = 0
/// ```
///
/// For the full documentation, check ``Forever/Forever``.
///
/// To fill this space, I have an amazing poem from ChatGPT.
/// ```
/// Oh variable, hear my plea,
/// DontDie, please stay alive for me.
/// With Forever, you'll persist,
/// Through any code or twist and twist.
///
/// Just conform to Codable's ways,
/// And you'll live on through endless days.
/// No need to fear the end of scope,
/// Forever's here, you'll never lose hope.
///
/// So hold on tight, don't let go,
/// With Forever, you'll always know
/// That you'll survive, no matter what,
/// DontDie, with Forever, you're not done yet.
/// ```
public typealias DontDie = Forever

/// What about telling a variable not to leave you? That's possible too.
///
/// ```swift
/// @DontLeaveMe("counter") var counter = 0
/// ```
///
/// For the full documentation, check ``Forever/Forever``.
///
/// At this point, this feels like an audition to figure out which typealias to use. Here's another equally as amazing rap by ChatGPT.
/// ```
/// Verse 1:
/// I got a typealias, it's called DontLeaveMe,
/// It's got my back, so you better believe me,
/// When I say it's the key to my code,
/// It's got my data on lock, never gonna corrode.
///
/// Chorus:
/// DontLeaveMe, DontLeaveMe,
/// Always by my side, you'll see,
/// DontLeaveMe, DontLeaveMe,
/// My trusty alias, the key to victory.
///
/// Verse 2:
/// It's got my back, through every line,
/// Making sure my data's always fine,
/// With DontLeaveMe, I'm never alone,
/// My trusty companion, I'll never moan.
///
/// Chorus:
/// DontLeaveMe, DontLeaveMe,
/// Always by my side, you'll see,
/// DontLeaveMe, DontLeaveMe,
/// My trusty alias, the key to victory.
///
/// Verse 3:
/// It's there when I need it, never far,
/// DontLeaveMe, my shining star,
/// With it, my code will always prevail,
/// DontLeaveMe, my programming grail.
///
/// Chorus:
/// DontLeaveMe, DontLeaveMe,
/// Always by my side, you'll see,
/// DontLeaveMe, DontLeaveMe,
/// My trusty alias, the key to victory.
///
/// Outro:
/// So when you see me with my head held high,
/// You know it's all thanks to DontLeaveMe, my ally,
/// With it, I'll never fall,
/// DontLeaveMe, the key to it all.
/// ```
public typealias DontLeaveMe = Forever

/// Be direct, tell a variable to be persistent.
///
/// ```swift
/// @BePersistent("counter") var counter = 0
/// ```
///
/// For the full documentation, check ``Forever/Forever``.
///
/// Here's another ChatGPT-generated passage. This time like a pep talk.
///
/// ```
/// Listen up team, I want to talk to you today about a powerful tool that we have in our arsenal, it's called BePersistent.
/// BePersistent is more than just a typealias, it's a mindset, it's a way of approaching every challenge that comes our way.
///
/// When you're faced with a difficult task, when you feel like giving up, that's when you need to turn to BePersistent. It reminds you that you are strong, that you are capable, and that you will not be defeated.
///
/// BePersistent means not giving up when things get tough, it means pushing through the pain and the obstacles, it means having the courage to keep going when everyone else has thrown in the towel.
///
/// So I want you to remember, whenever you're feeling down, whenever you're feeling like giving up, just think about BePersistent. Remember that you are strong, you are capable and you will not be defeated.
///
/// With BePersistent by your side, you can accomplish anything you set your mind to. So let's go out there and give it our all, let's show the world what we're made of, and let's be persistent in our quest for success.
///
/// Now let's get to work!
/// ```
public typealias BePersistent = Forever

/// A property wrapper to persist data automatically
///
/// `Forever` automatically manages persistence for you. As long as the property being persisted conforms to [`Codable`](https://developer.apple.com/documentation/swift/codable), when the value is set/updated, it gets written to a file.
///
/// The `@Forever` property wrapper works just like `@AppStorage` or `@SceneStorage` but for anything that's [`Codable`](https://developer.apple.com/documentation/swift/codable).
/// ```swift
/// @Forever("todos") var todos = [Todo(title: "Feed the cat", isCompleted: true),
///                                Todo(title: "Play with cat"),
///                                Todo(title: "Get allergies"),
///                                Todo(title: "Run away from cat"),
///                                Todo(title: "Get a new cat")]
/// ```
/// ```swift
/// struct Todo: Codable {
///     var title: String
///     var isCompleted = false
/// }
/// ```
/// Like other SwiftUI property wrappers, you can enable a child view to modify it's state by passing it as a [`Binding`](https://developer.apple.com/documentation/swiftui/binding). To get a binding to a `Forever` value, access the ``projectedValue``, by prefixing the property name with a dollar sign ($).
///
/// For instance, to create a todo list, you can use the following.
/// ```swift
/// List($todos, editActions: .all) { $todo in
///     Button {
///         todo.isCompleted.toggle()
///     } label: {
///         HStack {
///             Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
///             Text(todo.name)
///         }
///     }
/// }f
/// ```
///
/// Like `@AppStorage`, `@Forever` retrieves the stored value using a ``key``. The ``key`` should be unique to each item being stored.
/// If multiple properties use the same key, they will reference the same underlying value.
///
/// The keys point directly to a JSON file stored in the app's documents directory.
/// ```swift
/// @Forever("key") var apple = "apple"         // Points to "key.json"
/// @Forever("key") var banana = "banana"       // Points to "key.json"
/// @Forever("key") var pineapple = "pineapple" // Points to "key.json"
///
/// // apple == "apple"
/// // banana == "apple"
/// // pineapple == "apple"
/// ```
///
/// If a value cannot be retrieved, either because the value is not there or an error decoding the value, it will use the default value provided.
///
/// In the example below, when the variable is first initialized, `Forever` will store the value as 1.
/// ```swift
/// @Forever("myVariable") var myVariable = 0
/// // myVariable == 0
/// ```
/// However, if the value is set to something of a different data type with the same ``key``, `Forever` will reset the value and use the new default value.
/// ```swift
/// @Forever("myVariable") var myVariable = "Potato"
/// // myVariable == "Potato"
/// ```
///
/// Instead of creating multiple instances of `Forever`, you can pass a `Forever` property through `@Binding` variables or create a ViewModel and use an [`environmentObject`](https://developer.apple.com/documentation/swiftui/environmentobject) if you would like your `Forever` property to be accessible throughout your app.
///
/// It is best to ensure there is one instance of `Forever` in order to maintain a single source of truth.
///
/// In the example below, there are 2 instances of `@Forever("counter")`. When the button is pressed, the `Text` will not be updated.
/// The `Text` will only be updated if the app is restarted and a new value gets fetched.
/// ```swift
/// struct MyView: View {
///
///     @Forever("counter") var counter = 0
///
///     var body: some View {
///         Text("\(counter)") // Does not get updated
///         ButtonView()
///     }
/// }
/// ```
/// ```swift
/// struct ButtonView: View {
///
///     @Forever("counter") var counter = 0
///
///     var body: some View {
///         Button("Increment") {
///             counter += 1
///         }
///     }
/// }
/// ```
/// Instead, the `Forever` value should be passed as a [`Binding`](https://developer.apple.com/documentation/swiftui/binding) like the example below.
/// ```swift
/// struct MyView: View {
///
///     @Forever("counter") var counter = 0
///
///     var body: some View {
///         Text("\(counter)") // Gets updated
///         ButtonView(counter: $counter)
///     }
/// }
/// ```
/// ```swift
/// struct ButtonView: View {
///
///     @Binding var counter: Int
///
///     var body: some View {
///         Button("Increment") {
///             counter += 1
///         }
///     }
/// }
/// ```
///
/// To use `Forever` with UIKit and [`Combine`](http://developer.apple.com/documentation/combine), refer to ``publisher``.
///
/// ## Topics
/// ### Creating Forever
/// - ``init(wrappedValue:_:file:line:)``
/// - ``key``
///
/// ### Getting the value
/// - ``projectedValue``
/// - ``wrappedValue``
///
/// ### Combine
/// - ``publisher``
///
/// ### Don't like "Forever"?
/// - ``DontDie``
/// - ``DontLeaveMe``
/// - ``BePersistent``
@propertyWrapper public struct Forever<Value: Codable>: DynamicProperty {
    
    let subject = PassthroughSubject<Value, Never>()
    
    /// A key to retrieve the stored value
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
    
    /// A binding to the ``Forever`` value.
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
    }
}
