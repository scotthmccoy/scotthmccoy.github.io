When filtering AnyClass - that is, uninstantiated types - for conformance to a Protocol it can be tricky to know what version of `.Type` and `.self` to use to get a strongly typed result.

# Simple inline Version
Use `compactMap`, `as?` and `.Type` to get an array that you can invoke `Proto` funcs on.
```
protocol Proto { }
class Foo: Proto { }
class Bar: Proto { }
class Baz { }

let arr:[Proto.Type] = [Foo.self, Bar.self, Baz.self].compactMap {$0 as? Proto.Type}
// prints [__lldb_expr_220.Foo, __lldb_expr_220.Bar]
print(arr)
```
# Generic Version
This gets a lot trickier. The protocol arg must be `T.Type`, the return type must be `T`, and the protocol must be passed as `Proto.Type.self`.
```
import UIKit

// MARK: Protocol and class def
protocol Proto {
    init()
}
class Foo: Proto, CustomStringConvertible {
    required init() {}
    var description: String {
        "Instance of Foo"
    }
}
class Bar: Proto, CustomStringConvertible {
    required init() {}
    var description: String {
        "Instance of bar"
    }

}
class Baz { }


// MARK: Code
func filter<T>(
    classes: [AnyClass],
    byConformanceTo: T.Type
) -> [T] {
    classes.compactMap { $0 as? T }
}

let filtered:[Proto.Type] = filter(
    classes: [Foo.self, Bar.self, Baz.self],
    byConformanceTo: Proto.Type.self
)

print("Matching types: \(filtered)")
// return [Foo.self, Bar.self]

let instances = filtered.map {
    $0.init()
}

print("instances: \(instances)")

```
