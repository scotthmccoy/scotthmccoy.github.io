Compare T.Type using `is`
```
func create<T: BlogPost>(blogType: T.Type) -> T {
    switch blogType {
    case is TutorialBlogPost.Type:
        return blogType.init(subject: currentSubject)
    case is ArticleBlogPost.Type:
        return blogType.init(subject: getLatestFeatures().random())
    case is TipBlogPost.Type:
        return blogType.init(subject: getKnowledge().random())
    default:
        fatalError("Unknown blog kind!")
    }
}
```

Type: the type of an instance
Metatype: the type of a type
Static/Compile-time Metatype: the compile-time type of a construct
Dynamic/Runtime Metatype: the run-time type of a construct

Examples:

```
let swiftRocks = SwiftRocks() // swiftRocks has type SwiftRocks
let swiftRocksMetaType = type(of: swiftRocks) // swiftRocksMetaType has type SwiftRocks.Type

createWidget(ofType: MyWidget.self)  // ofType has type MyWidget.Type 

let someInstance: SomeBaseClass = SomeSubClass()
// The compile-time type of someInstance is SomeBaseClass,
// and the runtime type of someInstance is SomeSubClass

let myNum: Any = Int(1)
let dynamicMetaType = type(of: myNum) // dynamicMetaType is Int.type
```


