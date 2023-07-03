Swift Enums don't elegantly support enum intersecting with or being subsets of each other. For example, consider the following enums where Resource is a subset of Track. While you *could* use a common RawValue and then convert between them:

```
enum Track : String {
    case stability
    case influence
    case wealth
    case morale
    case welfare
    case knowledge
}

enum Resource : String {
    case influence
    case wealth
    case morale
    case welfare
    case knowledge
}

let resource = Resource(rawValue:Track.stability.rawValue)
```

But you're probably better off with an enum with an associated value:

```
enum Resource {
    case influence
    case wealth
    case morale
    case welfare
    case knowledge
}

enum Track {
    case resource(Resource)
    case stability
}
```

If you want more complexity than this (say, there's 3 groups each with some overlap) you're probably outgrowing enums and want to look at an `OptionSet` or even structs and protocols.
