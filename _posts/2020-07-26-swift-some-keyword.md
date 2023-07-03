
## The Problem

Say you want to return an Equatable from a function. This causes two errors - one when you try to implement it and another when you try to consume the result:  

```
func foo() -> Equatable { //🛑 Protocol 'Equatable' can only be used as a generic constraint because it has Self or associated type requirements
    return "strings are Equatable"
}

let x = foo()
let y = foo()
print(x == y) //🛑 Binary operator '==' cannot be applied to two 'Equatable' operands
```

## The Solution

Add the `some` keyword to the return type of the function. In the eyes of the compiler, this changes the return type to `String`:

```
func foo() -> some Equatable {
    return "strings are Equatable"
}

let x = foo()
let y = foo()
print(x == y)


print(type(of: x)) //Prints "String"
```

## How is this Useful? Why not just have it return String?

The use of an opaque result type allows you to make the actual return type an implementation detail by exposing only the interface provided by the protocol. This gives you flexibility of changing the concrete type later down the line without breaking any code that depends on the function.

For example, you could make the following replacement (change the return from a string to an Int) and not have to change *anything* else about your code, because you're dealing with the return as though **the only thing about it that matters is that it's Equatable**:

```
func foo() -> some Equatable {
    //return "strings are Equatable"
    return 42
}

let x = foo()
let y = foo()
print(x == y) //Prints "True"

print(type(of: x)) //Prints "Int"
```

