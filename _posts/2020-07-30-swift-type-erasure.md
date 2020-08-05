---
layout: post
title: 🐦 Swift - Type Erasure
date: 2020-07-30 17:16 -0700
---

## The Problem
One of the things left incomplete in Swift is being able to use PATs as a first-class type:

```
protocol Cup {
    associatedtype Contents
}

func foo(cup:Cup) { //🛑 Protocol 'Cup' can only be used as a generic constraint because it has Self or associated type requirements
    
}

let arr = [Cup<Tea>]() //🛑 Cannot specialize non-generic type 'Cup'
```

## Terms

Lets define a few terms before getting started:

* Associated Type: The name of the protocol's associatedtype. In the above example, this would be "Contents"
* Specialization: The concrete implementing type of the PAT, say, CoffeeMug.
* Concrete Type: The type associated to the specialization. In this case, Coffee.
* Public Wrapper: A generic class implementing the PAT. In this case, AnyCup.



## Solution #1 - The Type Erasure Pattern

Lets you treat the PAT as a generic class. This makes use of a neat swift trick: A generic container specialized by the concrete type `_AnyCupBase<Contents>` is subclassed to a generic container-container specialized by the specialization of the PAT, `_AnyCupBox<ConcreteCup:Cup>`. By the Liskov Substitution Principle, a reference of type `_AnyCupBase<Contents>` can refer to an `_AnyCupBox<ConcreteCup:Cup>`. So the public wrapper has a reference to a Base which is actually a Box which contains a concrete implementation (CoffeeMug) and the public wrapper AnyCup simply passes all Cup API interactions to the box which then pass it onto the CoffeeMug.    

It requires a lot of boilerplate code to create the Base, Box and Public Wrapper classes and all the trampolines to bounce interactions on the Public Wrapper back to the instance of the specialization retained inside the AnyPat's Box class. 


```
protocol Cup {
    // Have an associated type
    associatedtype Contents
    var description: String { get }
    // Use this associated type
    mutating func replaceContents(with newContents: Contents) -> Self
    func showContents() -> Contents?
}


struct Tea {
    let description = "tea"
    let hasMilk: Bool
}

struct Coffee {
    let description = "coffee"
    let isDecaf: Bool
}


struct TeaMug: Cup {
    // Assign a concrete type to the associated type as your first action. This is not necessary but will unleash the power of autocomplete.
    typealias Contents = Tea
    let description = "tea mug"
    private var contents: Tea?
    mutating func replaceContents(with newContents: Tea) -> TeaMug {
        contents = newContents
        return self
    }
    func showContents() -> Tea? {
        return contents
    }
}

struct CoffeeMug: Cup {
    typealias Contents = Coffee
    let description = "coffee mug"
    private var contents: Coffee?
    mutating func replaceContents(with newContents: Coffee) -> CoffeeMug {
        contents = newContents
        return self
    }
    func showContents() -> Coffee? {
        return contents
    }
}

struct CoffeeCup: Cup {
    typealias Contents = Coffee
    let description = "coffee cup"
    private var contents: Coffee?
    mutating func replaceContents(with newContents: Coffee) -> CoffeeCup {
        contents = newContents
        return self
    }
    func showContents() -> Coffee? {
        return contents
    }
}


var myCoffeeCup = CoffeeCup()
myCoffeeCup.replaceContents(with: Coffee(isDecaf: false))

var myTeaMug = TeaMug()
myTeaMug.replaceContents(with: Tea(hasMilk: true))


//1. Base class mocking the protocol
//First let’s define an abstract base class that describes the protocol Cup. The associated type Contents is now turned into a generic parameter for the class.
private class _AnyCupBase<Contents>: Cup {

    // All the properties in the Cup protocol go here.
    var description: String {
        get { fatalError("Must override") }
    }
    
    // Let's make sure that init() cannot be called to initialise this class.
    init() {
        guard type(of: self) != _AnyCupBase.self else {
            fatalError("Cannot initialise, must subclass")
        }
    }
    
    // All the methods in the Cup protocol here
    func replaceContents(with newContents: Contents) -> Self {
        fatalError("Must override")
    }
    func showContents() -> Contents? {
        fatalError("Must override")
    }
}


//2. A box containing a concrete instance of the Cup protocol
//Let’s define a box, where the concrete type for protocol Cup is stored: such box will inherit from our previously define abstract class.  By inheriting from _AnyCupBase, it also follows the Cup protocol. The generic parameter ConcreteCup also follows the protocol Cup. All methods and properties of ConcreteCup are wrapped by this class. Note that when referring to this class we need to specify a concrete type for Cup. For example: _AnyCupBox<TeaCup>. But, when referring to its superclass instead, we only need to specify a concrete type for its *Contents*! For example: _AnyCupBase<Tea>. Later, when we define AnyCup, this will allow us to hold a reference to a Cup based on what it's containing rather than what kind of container it is.
private final class _AnyCupBox<ConcreteCup: Cup>: _AnyCupBase<ConcreteCup.Contents> {
    // Store the concrete type
    var concrete: ConcreteCup
    
    // Override all properties
    override var description: String {
        get { return concrete.description }
    }
    
    // Define init()
    init(_ concrete: ConcreteCup) {
        self.concrete = concrete
    }
    
    // Override all methods
    override func replaceContents(with newContents: ConcreteCup.Contents) -> Self {
        concrete.replaceContents(with: newContents)
        return self
    }
    override func showContents() -> ConcreteCup.Contents? {
        return concrete.showContents()
    }
}

//3. The pseudo-protocol
//And finally we can define the public class that we are going to use.
final class AnyCup<Contents>: Cup {
    // Store the box specialised by its contents.
    // This line is the reason why we need an abstract class _AnyCupBase. We cannot store here an instance of _AnyCupBox directly because the concrete type for Cup is provided by the initialiser, at a later stage.
    private let box: _AnyCupBase<Contents>
    
    // All properties for the protocol Cup call the equivalent Box proerty
    var description: String {
        get { return box.description }
    }
    
    // Initialize the class with a concrete type of Cup where the contents is restricted to be the same as the genric paramenter
    init<Concrete: Cup>(_ concrete: Concrete) where Concrete.Contents == Contents {
        box = _AnyCupBox(concrete)
    }
    
    // All methods for the protocol Cup just call the e quivalent box method
    func replaceContents(with newContents: Contents) -> Self {
        box.replaceContents(with: newContents)
        return self
    }
    
    func showContents() -> Contents? {
        return box.showContents()
    }
}

//MARK: - Usage

// Use the generic type in a collection
let cupboardOne: [AnyCup<Coffee>] = [AnyCup(CoffeeMug()), AnyCup(CoffeeCup())]
let cupboardTwo: [AnyCup<Tea>] = [AnyCup(TeaMug()), AnyCup(TeaMug())]

// Return the generic type in a function (explicitely or implicitely)
func giveMeACupOfCoffee() -> AnyCup<Coffee>? {
    return cupboardOne.first
}

// Use the generic type as an input to a function
func describe(cup: AnyCup<Coffee>) {
    print(cup.description)
}

// Store a generic property
struct myShelf<Contents> {
    var cup: AnyCup<Contents>
}
```


## Solution #2 - Operationalization

The specialization converts itself (ideally through a function on a protocol extension on the PAT) into a non-generic type-erased Operation by creating or consuming closures that wrap interactions with the specialization. This allows a homogenous array of operations that might each operate on different specializations, effectively achieving a heterogeneous array of the PAT! It also free consumers to be focused solely on their own responsibilities (consuming operations) instead of performing type erasure or dealing with generics.

```
//MARK: - Request protocol + extention to make RequestOperations
protocol Request {
    associatedtype Response
    associatedtype Error: Swift.Error

    typealias Handler = (Result<Response, Error>) -> Void

    func perform(then handler: @escaping Handler)
}

extension Request {
    
    //Pass in a response Handler of the Requests' request Handler type
    func makeOperation(resultHandler: @escaping Handler) -> RequestOperation {
        
        
        return RequestOperation { requestQueueCleanupHandler in
            // We actually want to capture 'self' here, since otherwise
            // we risk not retaining the underlying request anywhere.
            self.perform { result in
                
                //Call the result handler
                resultHandler(result)
                
                //Defer clean up in the request queue until after the response has been handled
                requestQueueCleanupHandler()
            }
        }
    }
}

//This is the bridge between Request and RequestQueue.
//It wraps a Request and its Handler by wrapping them in a closure which can then be invoked
//from a function with no type
struct RequestOperation {
    fileprivate let performRequestHandleResultAndCleanup: (@escaping () -> Void) -> Void

    func perform(requestQueueCleanupHandler: @escaping () -> Void) {
        performRequestHandleResultAndCleanup(requestQueueCleanupHandler)
    }
}

enum RequestError : Error {
    case generalRequestFault
}


//Structs that implement Request
struct StringRequestAlwaysSucceeds : Request {
    typealias Response = String
    typealias Error = RequestError

    func perform(then handler: @escaping Handler) {
        handler(.success("Succeeded, as expected"))
    }
}

struct IntRequestAlwaysSucceeds : Request {
    typealias Response = Int
    typealias Error = RequestError

    func perform(then handler: @escaping Handler) {
        handler(.success(12345))
    }
}

class RequestQueue {
    private var queue = [RequestOperation]()
    private var ongoing: RequestOperation?

    // Since the type erasure now happens before a request is
    // passed to the queue, it can simply accept a concrete
    // instance of 'RequestOperation'.
    func add(_ operation: RequestOperation) {
        guard ongoing == nil else {
            queue.append(operation)
            return
        }

        perform(operation)
    }

    private func perform(_ operation: RequestOperation) {
        ongoing = operation

        operation.perform { [weak self] in
            self?.ongoing = nil
            print("perform next request if queue is not empty")
        }
    }
}

let requestQueue = RequestQueue()

requestQueue.add(IntRequestAlwaysSucceeds().makeOperation(resultHandler: { result in
    switch result {
        case .success(let int):
            print("int: \(int)")
        case .failure(let error):
            print("error: \(error)")
    }
}))

requestQueue.add(StringRequestAlwaysSucceeds().makeOperation(resultHandler: { result in
    switch result {
        case .success(let string):
            print("string: \(string)")
        case .failure(let error):
            print("error: \(error)")
    }
}))
```

## Notes

Operationalization technique can be complementary to the Type Erasure Pattern, allowing AnyPats of any concrete type to convert themselves into Operations which can then be added to a collection or it can replace the Type Erasure Pattern completely as Operations are nongeneric. 
