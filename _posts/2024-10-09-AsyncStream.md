On https://stackoverflow.com/questions/78192688/how-to-make-an-actors-isolated-state-observable, Scott Thompson says 
> people have run into many problems trying to mix async Swift and Combine. It's generally better to use one or the other. To use async swift then state would be a async sequence and you would monitor it from outside of the actor using a for loop over the sequence.

I've cobbled together an AsyncStream version of an observable actor, but unlike a Publisher, requires a Task dedicated to awaiting outputs from the iterator.

It also doesn't work all the way, and I can't be bothered to fix it. You can see in the output that the Apple and Banana subscribers each only get a portion of the intended output. I'm sure I could figure out how to get the actor to provide a unique stream to each subscriber, store the subscribers in a dict or something, and cancel them to free up the dedicated Tasks, but at that point I feel like I would have just re-created the Observable Actor.

```
import UIKit
import PlaygroundSupport

// From https://developer.apple.com/documentation/swift/asyncstream

struct Quake {
    let magnitude: Double
}

actor QuakeMonitor {
    private var magnitude = 1.0
    
    
    private var timerTask: Task<(), Never>?
    private var stream: AsyncStream<Quake>?
    private var continuation: AsyncStream<Quake>.Continuation?
        
    func startStream() -> AsyncStream<Quake> {
        print("start stream")
        
        if let stream {
            return stream
        }
        
        let (stream, continuation) = AsyncStream<Quake>.makeStream()

        self.stream = stream
        self.continuation = continuation

        
        
        self.timerTask = Task(priority: .utility) { [weak self] in
            print("inside task")
            
            while !Task.isCancelled {
                print("inside while loop")
                guard let self else {
                    print("bailing")
                    return
                }
                print("calling sendQuake")
                guard await sendQuake() else {
                    return
                }
                
                print("sleeping...")
                try? await Task.sleep(nanoseconds: UInt64(0.5 * 1_000_000_000))
            }
        }
        
        return stream
    }
    
    func stop() {
        timerTask?.cancel()
        timerTask = nil
    }
    
    private func sendQuake() -> Bool {
        print("sendQuake")
        continuation?.yield(Quake(magnitude: magnitude))
        magnitude += 1
        
        guard magnitude <= 3 else {
            timerTask?.cancel()
            continuation?.finish()
            return false
        }
        
        return true
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
print("Creating QuakeMonitor...")

let quakeMonitor = QuakeMonitor()

await withTaskGroup(of: Void.self) { group in
    group.addTask {
        for await quake in await quakeMonitor.startStream() {
            print("🍎 Quake Received: \(quake.magnitude)")
        }
        print("🍎 after stream")
    }

    group.addTask {
        for await quake in await quakeMonitor.startStream() {
            print("🍌 Quake Received: \(quake.magnitude)")
        }
        print("🍌 after stream")
    }
}


print("Ending execution...")
PlaygroundPage.current.finishExecution()
```

Output:
```
Creating QuakeMonitor...
start stream
inside task
inside while loop
calling sendQuake
start stream
sendQuake
🍎 Quake Received: 1.0
sleeping...
inside while loop
calling sendQuake
sendQuake
🍌 Quake Received: 2.0
sleeping...
inside while loop
calling sendQuake
sendQuake
🍎 Quake Received: 3.0
🍌 after stream
```
