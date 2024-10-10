All structs should implement `Equatable` (or `Comparable`, which includes `Equatable`) to support unit testing.



# Data Structs

Data structs model how the app's data is stored in a particular source of truth like a database, data file, or API. 

Keep different sets of structs for each method of serialization/deserialization. This allows changes to and simultaneous support for different versions of different serialization methods without affecting your Domain layer. For example, you could decide to change the structure of your in-app database to support faster queries, add support for a v2 of your backend, or fix a field naming issue without having to change the names of all the fields in the Domain layer of your app.

These structs should:
- Implement a convenience init from the equivalent Domain Struct
- Implement a computed var to convert to the equivalent Domain Struct
- Alternately, create a Factory that converts between the two types.
- Implement `Codable` so that state can be saved and restored
  - For mutable properties, use optional vars with default values so that unexpected changes in format are less likely to result in Codable failures. Example: `var id: UUID? = UUID()` or `var name: String?`.
  - For immutable properties, use `let propertyName:Type`
  - For constants, use `var propertyName:Type { return constantValue }`
  - Note: using `let propertyName = defaultValue` with `Codable` throws a warning for the property unless you define `CodingKeys` which is its own implementation and maintenance headache.
  
Structs that follow this should play nicely with Codable without needing to define a convenience initializer on an extension.

 
## Domain Structs

Domain structs represent the State of your app. Generally these should be lightweight and not have any logic or validation on them - that logic can be provided by a Manager or Repository in the Domain layer itself. 

- Generally, all domain struct properties should be mutable and Non-Optional unless the property determines the struct's Identity (see below).
- Element structs (structs that are displayed in Lists/ForEach in SwiftUI should implement **Identifiable** to support being able to quickly determine which struct is being examined/modified and to guarantee uniqueness during comparisons. If a struct's identity is informed by a relationship (such as how a PlayerEndGameState is owned by a particular player), try to use that id via a computed property (var get).
