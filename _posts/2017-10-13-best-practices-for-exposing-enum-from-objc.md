Given:
1. Enums have to be Int to be exposed to obj-C.
2. Vars and Functions defined on them will not be visible to obj-c.
3. It's nice to be able to use .description and string interpolation

This is the best I've found so far:

```
@objc public enum OXMLogLevel: Int, CustomStringConvertible {
    case info = 0
    case warn = 1
    case error = 2
    case none = 3
    
    public var description: String {
        return OXMFunctions.toString(self)
    }
}
```
