---
layout: post
title: Swift - Arrays of Generics of Mixed Types, Why Not To Do That, and why Type Erasure is Not A Solution
date: '2020-01-14T12:03:00.000-08:00'
author: Scott McCoy
tags: 
modified_time: '2020-01-15T12:43:18.667-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-5129331290565549229
blogger_orig_url: https://scotthmccoy.blogspot.com/2020/01/swift-array-of-generics-of-mixed-types.html
---

Most common data formats (Json, Plist, XML) support arrays of mixed types like: `["foo", 1, {"a":3}]` and I often find myself wanting to mirror that in Swift. For example, I often find myself wanting to make a generic AppSetting class that can consume/represent any data type, wraps UserDefaults and provides functionality like CustomStringConvertible:

```
class AppSetting<T> {
    var data:T
    
    init(_ data:T) {
        self.data = data
    }
}
```

Unfortunately, once the generic class definition is resolved to a concrete type, say  `AppSetting<Int>` and `AppSetting<String>`, they're just as different from each other as an `Int` and a `String` are and you get the same "Don't mix types" errors if you try to put them into an array:

```
let firstElem = AppSetting(1)
let secondElem = AppSetting("Foo")
let arr = [firstElem, secondElem]
🛑 Heterogeneous collection literal could only be inferred to '[Any]'; add explicit type annotation if this is intentional
```

## Non-Solutions

1. Making it an array of `AppSetting<Any>` doesn't work because that's *also* a distinct type:

    ```
    let firstElem = AppSetting(1)
    let secondElem = AppSetting("Foo")
    let arr:[AppSetting<Any>] = [firstElem, secondElem]
    🛑 Cannot convert value of type 'AppSetting<Int>' to expected element type 'AppSetting'
    ```

2. Make the elements explicitly of type `AppSetting<Any>` compiles, but it wipes out the usefulness of generics. 
    ```
    let firstElem:AppSetting<Any> = AppSetting(1)
    let secondElem:AppSetting<Any> = AppSetting("Foo")
    let arr:[MyClass<Any>] = [firstElem, secondElem]
    ```

    This wipes out the utility of having MyClass be generic since elements of the array are now explicitly `MyClass<Any>` rather than `MyClass<Int>` or `MyClass<String>`. 

3. Making array of type  `Any` is arguably the most faithful mirror of the typeless JSON array we're trying to mimic, but we'd obviously like *some* kind of type checking:   
    ```
    let firstElem = AppSetting(1)
    let secondElem = AppSetting("Foo")
    let arr:[Any] = [firstElem, secondElem]
    ```

So what's the nost elegant way to get an array of mixed types, but with some type checking?


## Solutions

1. Create a dummy protocol `AppSettingProtocol` which `AppSetting` conforms to and then make a `[AppSettingProtocol]` array, essentially *obscuring* the `AppSetting<T>` type. 
    
    ```
    protocol AppSettingProtocol{}

    class AppSetting<T> : AppSettingProtocol {
        var data:T
        
        init(_ data:T) {
            self.data = data
        }
    }
     
    let firstElem = AppSetting(1)
    let secondElem = AppSetting("Foo")
    let arr:[AppSettingProtocol] = [firstElem, secondElem]
    ```

    This is sort of like having an abstract superclass.

    It's tempting to add an `Associated Type` to the protocol so you know something about what's in the array, but Protocols with associated types have the same effective restrictions that Generics do and for many of the same reasons: 
    
    ```
    protocol MyProtocol {
        associatedtype MyType    
    }
    "Protocol 'SettingProtocol' can only be used as a generic constraint because it has Self or associated type requirements"
    ```

    It's also good to know that MyProtocol can't have Self requirements (like Equatable does) if you want to have it be the type of an array. This keeps you from making an array of Equatable which makes sense since if you could, you could have an array of objects of mixed types that might not be Equatable with each *other*. For example, two Doubles are Equatable, but you  [Self requirements](https://www.bignerdranch.com/blog/why-associated-type-requirements-become-generic-constraints/) like this in a little more depth. 



4. Enums with Associated Values

    Example from [SwiftyPlist](https://github.com/VinceBurn/SwiftyPlist/blob/master/Pod/Classes/Plist.swift):

    ```
    enum EntityType {
        case string(String)
        case number(NSNumber)
        case date(Date)
        case data(Data)
        case array([Plist])
        case dictionary([String : Plist])
    }

    let arr = [EntityType.string("Foo"), EntityType.date(Date())]
    ``` 

    As you can see, writing to an enum with an associated type is quite elegant. But getting a primitive value back out from one requires a lot of awful switch case code: 

    My impulse was to immediately try to encapsulate the accessor code away behind a StringSetting or IntSetting class that knows exactly what data type it's managing and can expose a primitive property. Which brings me back around to my original idea...


5. Just make an abstract class with very limited functionality and make subclasses that explicitly expose a primitive of the the type they handle:

    ```
    let arr:[AbstractSetting] = [StringSetting("Foo"), IntSetting(1)]
    ```



## The Type Erasure Pattern
The Type Erasure Pattern is a solution to a *different* problem.

You create 3 classes - an Abstract Base which subclassed in order to bind the generic type constraint to our protocol’s associated type, a Box, and a Public Wrapper. The 
[Big Nerd Ranch](https://www.bignerdranch.com/blog/breaking-down-type-erasure-in-swift) discusses this in depth.
The Type Erasure Pattern is a solution to a *different* problem. Instead of letting you make an array of *different* types, it allows you to make an array of *different class instances that conform to the same protocol* so long as they have the same *associated type*. So it won't let you fake your way to `[1, "2", Dictionary]`, but it will let you make something like 
```
let arr:[AnyHandler<Int>] = [IntHandler(1), DifferentKindOfIntHandler(1), VeryDifferentIntHandler(1)]
```
Where AnyHandler conforms to 

Since the Type Erasure Pattern essentially substitutes a class for the protocol, to me this seems functionally equivalent to making an abstract generic `MyClass<T>` and then making an array of `MyClass<Int>` but with extra steps. The payoff for those steps is that you then get to effectively use a protocol instead of a class which can be a big help in a complex project, but YAGNI, probably.

Note: Type Erasure is a CS term that in *Swift* means "use generics", and the Type Erasure *Pattern* is a particular software design pattern relying heavily on the use of generics.










When is the Type Erasure Pattern *Useful*?

```
protocol Identifiable {
    associatedtype ID
    var id: ID { get set }
}

struct Person: Identifiable {
    var id: String
}

struct Website: Identifiable {
    var id: URL
}

func compareThing1(_ thing1: Identifiable, against thing2: Identifiable) -> Bool {
    return true
}

🛑 protocol 'Identifiable' can only be used as a generic constraint because it has Self or associated type requirements
```
This makes sense, if we didn't have this compilation error we'd be able to make an array of all `Equatable`s or something equally maddening.



[This Guy](https://medium.com/capital-one-tech/an-alternative-to-type-erasure-for-generic-protocols-a9a48e96618a)'s approach to the associated type problem is to just not use associated types 

```
protocol Fetchable {
    associatedtype DataType
    func fetch(completionBlock: @escaping ([DataType]?) -> Void)
}

protocol FetchableType {}

protocol Fetchable {
    func fetch(completionBlock: @escaping (FetchableType) -> Void)
}

struct FlightBookingsWrapper: FetchableType {
    let bookings: [FlightBooking]?
}

struct HotelBookingsWrapper: FetchableType {
    let bookings: [HotelBooking]?
}

struct RentalBookingsWrapper: FetchableType {
    let bookings: [RentalBooking]?
}

struct FlightBookingFetcher: Fetchable {
    func fetch(completionBlock: @escaping (FetchableType) -> Void) {
        completionBlock(
            FlightBookingsWrapper(bookings: [
                FlightBooking(identifier: "VX-XUJURM",
                              startDate: Date.bookingDate(from: "2017-11-12T10:30:00+0000"),
                              endDate: Date.bookingDate(from: "2017-11-16T09:00:00+0000"),
                              flightNumber: "VX-1511",
                              from: "SFO",
                              to: "SEA",
                              isRoundTrip: true)
                ]))
    }
}

struct HotelBookingFetcher: Fetchable {
    func fetch(completionBlock: @escaping (FetchableType) -> Void) {
        completionBlock(
            HotelBookingsWrapper(bookings: [
                HotelBooking(identifier: "MC-83027626",
                             startDate: Date.bookingDate(from: "2017-11-12T00:00:00+0000"),
                             endDate: Date.bookingDate(from: "2017-11-16T00:00:00+0000"),
                             roomNumber: 304)
                ]))
    }
}

struct RentalBookingFetcher: Fetchable {
    func fetch(completionBlock: @escaping (FetchableType) -> Void) {
        completionBlock(
            RentalBookingsWrapper(bookings: [
                RentalBooking(identifier: "ENT-2856847",
                              startDate: Date.bookingDate(from: "2017-11-12T00:00:00+0000"),
                              endDate: Date.bookingDate(from: "2017-11-16T00:00:00+0000"),
                              model: "Fiesta",
                              make: "Ford")
                ]))
    }
}

struct BookingCoordinator {
    public func fetch() {
        let fetchers: [Fetchable] = [FlightBookingFetcher(), HotelBookingFetcher(), RentalBookingFetcher()]
        for fetcher in fetchers {
            fetcher.fetch { (bookings) in
                print(bookings)
            }
        }
    }
}
```
This is honestly not bad, but I think the point of the Type Erasure Pattern is to create 3 new classes and then you can use *anything* that conforms to that protocol in that array,






The Crusty Video 

Instead of classes, make structs that implement protocols.

1. Protocols essentially give you multiple inheritance.
2. Structs are Value types - faster and more thread safe! 

Dave & Crusty made the following:
1. Some Shape structs that implmented a Drawable protocol
2. A TestRenderer struct that implemented a Renderer protocol
3. An extension on CGContext so that it implements Renderer(!!!) 

```
protocol Drawable {
    func draw(renderer:Renderer)
}
```

The assertion is that protocols and Generics are much better than mocks for testability.

protocol extensions not only do not extend the contract explicit in the original protocol, they *require* you to implement 
In an extension protocol, you can create a default implementation. 


> Mocks are inherently fragile; You have to couple testing code to the implementation details of the code under test.



Constrained extensions

You can make a protocol extension (with a nice default implementation!!) that only applies where an associated type is also something else.
Instead of having to apply an extension to a bunch of different classes, potentially infinite, you make the protocol extension opt into applying only when the associated type is also something else! 



A self requirement puts it in the homogeneous, statically dispatched world. But Diagram really needs a heterogeneous array of Drawables so we can put polygons and circles in the same array.



You want to use classes when copying or comparing instances doesn't make sense (Window)
Instance lifetime is tied to external effects. The compiler does lots of optimization on value types' lifetimes but a class sticks around.
When the class would be a "sink"; a write-only conduit to an external state.

