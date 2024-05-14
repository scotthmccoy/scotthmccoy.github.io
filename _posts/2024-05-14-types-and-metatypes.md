- Type: the type of an instance
- Metatype: the type of a type
- Static/Compile-time Metatype: the compile-time type of a construct
- Dynamic/Runtime Metatype: the run-time type of a construct

![image](https://github.com/scotthmccoy/scotthmccoy.github.io/assets/62034899/52afad8f-a1b3-4288-acc8-704115bd22e3)

# Metatypes 

Metatypes are useful for type comparisons:
```
func create<T: BlogPost>(blogType: T.Type) -> T {
    switch blogType {
    case is TutorialBlogPost.Type:
        return blogType.init(subject: currentSubject)
    case is ArticleBlogPost.Type:
        return blogType.init(subject: getLatestFeatures().randomElement()!)
    case is TipBlogPost.Type:
        return blogType.init(subject: getKnowledge().randomElement()!)
    default:
        fatalError("Unknown blog kind!")
    }
}

let blogPost: BlogPost = create(blogType: ArticleBlogPost.self)
```

You get a metatype from type(of:)
```
let fooMetaType = type(of: Foo()) // fooMetaType has type Foo.Type
```


# Static and Dynamic Metatypes
This just refers to what the compiler knows at compile type verus what the Swift runtime knows at runtime.

For example:
```
let instance: BaseClass = SubClass()
```
The static, or compile-time type of `instance` is `BaseClass`, but its dynamic, or runtime type is `SubClass`.

A More Complicated Example:
```
let myNum: Any = Int(1)
let dynamicMetaType = type(of: myNum)
```
The compile-time type of myNum is Any, but its runtime type is Int, and `dynamicMetaType` is of type `Int.Type`.
