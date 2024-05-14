Compare T.Type using `is`. 

The following will print foo bar or baz.
```
// Protocol
protocol BlogPost {
    init(subject: String)
}

// Structs
struct TutorialBlogPost: BlogPost {
    init(subject: String) {
        print(subject)
    }
}

struct ArticleBlogPost: BlogPost {
    init(subject: String) {
        print(subject)
    }
}

struct TipBlogPost: BlogPost {
    init(subject: String) {
        print(subject)
    }
}

// Data providers
func getLatestFeatures() -> [String] {
    ["foo", "bar", "baz"]
}

func getKnowledge() -> [String] {
    ["animal", "vegetale", "mineral"]
}

var currentSubject = "current"

// The Example!
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


