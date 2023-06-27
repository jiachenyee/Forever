# Forever

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjiachenyee%2Fforever%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/jiachenyee/forever)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjiachenyee%2Fforever%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/jiachenyee/forever)

## Persist any `Codable` value.

> For full documentation, click [here](https://forever.jiachen.app/documentation/forever/forever).

```swift
@Forever("todos") var todos = [Todo(title: "Feed the cat", isCompleted: true),
                               Todo(title: "Play with cat"),
                               Todo(title: "Get allergies"),
                               Todo(title: "Run away from cat"),
                               Todo(title: "Get a new cat")]
```
```swift
struct Todo: Codable {
    var title: String
    var isCompleted = false
}
```

## One line and it lasts `@Forever`.
```swift
@Forever("counter") var counter = 1
```

## Using UIKit? `Forever`+Combine
Thanks https://github.com/jiachenyee/Forever/issues/1.
```swift
class ViewController: UIViewController {

    @Forever("counter") var counter = 1
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _counter.publisher.sink(receiveValue: { value in
            print(value)
        })
        .store(in: &cancellables)
    }
    //...
}
```

## Don't like _Forever_? Use another one.
```swift
@DontDie("name") var name = "Potato"
@DontLeaveMe("todo") var todo = Todo(...)
@BePersistent("a") var b = true
```

## Installation
### Requirements
| Platform | Version       |
|:--------:|:--------------|
|   iOS    | 13.0 or later |
|  macOS   | 11.0 or later |
| watchOS  | 6.0 or later  |
|   tvOS   | 13.0 or later |

### Add as Swift Package
In Xcode, File → Add Packages… → Paste `https://github.com/jiachenyee/forever` in the search field.
