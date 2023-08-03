It's common to want to define stateless code using a static function on a class or struct, but that can make it awkward to dependency-inject via a protocol. Swift offers a couple decent ways to pull this off: passing the type and a generic function.

```
import UIKit

protocol MyProtocol {
    static func foo()
    static func bar()
}

class MyClass: MyProtocol {
    static func foo() {
        print("foo")
    }
    
    static func bar() {
        print("bar")
    }
}

class MyClass2: MyProtocol {
    static func foo() {
        print("foo2")
    }
    
    static func bar() {
        print("bar2")
    }
}

// Explicit Type Approach
func doItType(type: MyProtocol.Type) {
    type.bar()
}
doItType(type: MyClass.self)
doItType(type: MyClass2.self)

// Generic Approach
func doItGeneric<T:MyProtocol>(type: T.Type) {
    type.foo()
}
doItGeneric(type: MyClass.self)
doItGeneric(type: MyClass2.self)

```
