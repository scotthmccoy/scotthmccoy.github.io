---
layout: post
title: 🐦 Structs - Best Practices
date: 2021-11-20 16:05 -0800
---
 
All structs should implement `Equatable` (or `Comparable`, which includes `Equatable`) to support unit testing.
 
## State Structs

State structs represent the state of the Model. Non-state structs are the output of operations on that state.

Implement `Codable` so that state can be saved and restored


Properties should use the following pattern:

* For mutable properties, use `var propertyName = defaultValue`
* For immutable properties, use `let propertyName:Type`
* For constants, use `var propertyName:Type { return constantValue }`

This pattern has the following benefits:

* It plays nice with `Codable`. Using `let propertyName = defaultValue` with `Codable` throws a warning for the property unless you define `CodingKeys` which is its own implementation and maintenance headache.
* Structs won't need to define a convenience initializer on an extension

Generally, all state struct properties should be mutable unless the property determines the struct's Identity (see below).

 
## Element Structs

Element structs go into arrays, Non-Element structs don't.

Implement **Identifiable** to support being able to quickly determine which struct is being examined/modified and to guarantee uniqueness during comparisons. If a struct's identity is informed by a relationship (such as how a PlayerEndGameState is owned by a particular player), try to use that id via a computed property (var get).

Non-Element Structs that aren't are probably the children of Element structs and should probably be examined for opportunities to refactor them together with their parent Element struct.