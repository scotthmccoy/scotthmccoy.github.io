
Most common data formats (Json, Plist, XML) support arrays of mixed types like: `["foo", 1, {"a":3}]` and I often find myself wanting to have something like that in Swift. For example, I often find myself wanting to make a generic AppSetting class that can consume/represent any data type, wraps getting and setting in UserDefaults and provides functionality like CustomStringConvertible:

```
class AppSetting<T> {
    var data:T
    
    init(_ data:T) {
        self.data = data
    }
}
```

Unfortunately, once the generic is specialized to say  `AppSetting<Int>` and `AppSetting<String>`, the specializations are first-class types just like `Int` and `String` are and you get the same "Don't mix types" errors you would get if you try to put a `String` and an `Int` into an array:

```
let firstElem = AppSetting(1)
let secondElem = AppSetting("Foo")
let arr = [firstElem, secondElem] //🛑 Heterogeneous collection literal could only be inferred to '[Any]'; add explicit type annotation if this is intentional
```



## Solutions

1. Inheritance 
    Make an abstract class with subclasses that explicitly expose a value of the the type they handle. 

    ```
    let arr:[AbstractSetting] = [StringSetting("Foo"), IntSetting(1)]
    ```

2. Dummy Protocol 
    
    Make an `AppSettingProtocol` which `AppSetting` conforms to and make an array of the dummy protocol. You essentially obscure the `AppSetting<T>` type, and then conditionally cast the array elements: 
    
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
    

    let random = arr.randomElement()

    if let intSetting = random as? AppSetting<Int> {
        print(intSetting.data)
    } else if let stringSetting = random as? AppSetting<String> {
        print(stringSetting.data)
    }
    ```
    
    You get *some* type checking in that the compiler knows which types are unrelated to the dummy protocol:
    ```
    if let intVersion = random as? Int { //⚠️ Cast from 'AppSettingProtocol?' to unrelated type 'Int' always fails
        print(intVersion.data)
    }
    ```
    
    But wouldn't it be nice if the compiler forced you to enumerate all the possible casts of the element?


4. Enums with Associated Values

    Writing to one is elegant but reading the value back out gets more repetitious with each possible associated value since the switch must be exhaustive and each case must have at least one line of executable code: 

    ```
    import Foundation

    enum EntityType {
        case string(String)
        case int(Int)
        case double(Double)
        case date(Date)
        case array([EntityType])
        case dictionary([String : EntityType])
    }

    let arr = [EntityType.string("Foo"), EntityType.date(Date())]
    let element = arr[1]

    switch element {
        case .string(let string):
            print("string: \(string)")
        case .int(let int):
            print("int: \(int).")
        case .double(let double):
            print("double: \(double).")
        case .date(let date):
            print("date: \(date).")
            
        case .array(_):
            break
        case .dictionary(_):
            break
    }    
    ``` 

5. Use closures as adapters between the current scope and a wrapper type. The folks at Capital One used this approach [here](https://medium.com/capital-one-tech/an-alternative-to-type-erasure-for-generic-protocols-a9a48e96618a). And I describe a more formalized version of this method as "Operationalization" in my [Swift Type Erasure Post](https://scotthmccoy.github.io/2020/07/30/type-erasure.html).

## Partial Solutions and Non-Solutions

1. Making the array of type  `AppSetting<Any>` but keeping the elements as `AppSetting<Int>` and `AppSetting<String>` doesn't work because  `AppSetting<Any>` is not a more generic type like `Any`, it's its own distinct type:

    ```
    let firstElem = AppSetting(1)
    let secondElem = AppSetting("Foo")
    let arr:[AppSetting<Any>] = [firstElem, secondElem] //🛑 Cannot convert value of type 'AppSetting<Int>' to expected element type 'AppSetting'
    ```

2. Making the elements explicitly of type `AppSetting<Any>` compiles, but it completely wipes out the usefulness of generics since elements of the array are now explicitly `MyClass<Any>` rather than `MyClass<Int>` or `MyClass<String>`:
    ```
    let firstElem:AppSetting<Any> = AppSetting(1)
    let secondElem:AppSetting<Any> = AppSetting("Foo")
    let arr:[MyClass<Any>] = [firstElem, secondElem]
    ```

3. Making the array of type  `Any` is arguably the most faithful mirror of JSON's typeless arrays but we'd obviously like *some* kind of type checking:   
    ```
    let firstElem = AppSetting(1)
    let secondElem = AppSetting("Foo")
    let arr:[Any] = [firstElem, secondElem]
    ```
    
4. The Type Erasure Pattern (detailed on my [Swift Type Erasure post]({{ site.url }}/2020/07/30/swift-type-erasure.html)) is *not* a solution since it makes a PAT into a generic class which still can't be put into a heterogeneous array.

It's tempting to add an `Associated Type` to the protocol so you know something about what's in the array, but Protocols with associated types have the same effective restrictions that Generics do and for many of the same reasons: 

```
protocol MyProtocol {
    associatedtype MyType    
}
"Protocol 'SettingProtocol' can only be used as a generic constraint because it has Self or associated type requirements"
```
