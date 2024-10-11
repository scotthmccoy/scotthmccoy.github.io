You can use `@unchecked Sendable` to mark a class as safe to be transferred accross isolation domains. In this example, we've implemented our own synchronization with a DispatchQueue:

```
final class MyClass: @unchecked Sendable {
    private var value: Int = 0
    private let queue = DispatchQueue(label: "com.myapp.syncQueue")

    func updateValue(_ newValue: Int) {
        queue.sync {
            self.value = newValue
        }
    }
    
    func getValue() -> Int {
        return queue.sync { value }
    }
}
```
