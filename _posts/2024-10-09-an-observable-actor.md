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
    await actor.message(param:30)
    await actor.message(param:40)
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
setting state: 30
🍎 30
🍌 30
setting state: 40
🍎 40
🍌 40
```

