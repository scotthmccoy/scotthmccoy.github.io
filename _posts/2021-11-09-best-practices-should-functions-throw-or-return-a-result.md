---
layout: post
title: '🐦 Swift Best Practices: should functions throw or return a Result?'
date: 2021-11-09 18:48 -0800
---

Unless it's meant to be used with function chaining, it's generally better practice to use `throws` rather than returning a `Result`. This is for similar reasons as to why `guard let` is generally better practice than `if let`: the compiler *forces* the invoker to consider handling non-happy-path cases.

The downsides to throws (having to wrap variable assignement in a `do` block) can largely be mitigated in the following way:

```
extension Result {
    func getError() -> Error? {
        guard case let .failure(error) = self else {
            return nil
        }
        return error
    }
}


let result = Result { try functionThatThrows() }.map({$0 + "!"})

guard case let .success(string) = result else {
    print("Error: \(result.getError()!)")
    exit(1)
}

print(string)
```
