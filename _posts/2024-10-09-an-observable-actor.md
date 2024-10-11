```
import UIKit
import Combine
import PlaygroundSupport

actor MyActor {
    @MainActor public var observableState: AnyPublisher<Int, Never>?
    private var state: CurrentValueSubject<Int, Never>

    public init(initialState: Int) {
        self.state = .init(initialState)
        
        let anyPublisher = self.state.eraseToAnyPublisher()
        Task {
            await MainActor.run {
                self.observableState = anyPublisher
            }
        }
    }

    public func message(param: Int) {
        print("setting state: \(param)")
        state.value = param
    }
}

Task {
    let actor = MyActor(initialState: 3)

    let subscription = await actor.observableState?.sink { value in
        print("🍎 \(value)")
    }
    
    let subscription2 = await actor.observableState?.sink { value in
        print("🍌 \(value)")
    }

    await actor.message(param:10)
    await actor.message(param:20)
    
    print ("adding another subscriber...")
    let subscription3 = await actor.observableState?.sink { value in
        print("🦀 \(value)")
    }
    
    print("Sending more messages...")
    await actor.message(param:30)
    await actor.message(param:40)
    
    print("cancelling 🍌...")
    subscription2?.cancel()
    
    await actor.message(param:50)
    await actor.message(param:60)
}
```

Output:
```
🍎 3
🍌 3
setting state: 10
🍎 10
🍌 10
setting state: 20
🍎 20
🍌 20
adding another subscriber...
🦀 20
Sending more messages...
setting state: 30
🍎 30
🦀 30
🍌 30
setting state: 40
🍎 40
🦀 40
🍌 40
cancelling 🍌...
setting state: 50
🍎 50
🦀 50
setting state: 60
🍎 60
🦀 60
```

This works in Swift 5.10.1, but in 6.0, fails with  `'self'-isolated value of type '() async -> ()' passed as a strongly transferred parameter; later accesses could race` and `Sending 'anyPublisher' risks causing data races`:
<img width="957" alt="image" src="https://github.com/user-attachments/assets/0a4b9109-f482-46dc-86f4-03b1efc9b062">





