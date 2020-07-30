---
layout: post
title: 🐦 Swift - Enums for Router, Theme and Binary Tree
date: 2020-07-29 18:56 -0700
---

## Router Pattern
```
enum Router {
    case user(id: Int)
    case weather(day: Day)
}

extension Router {
    var url: String {
        switch self {
        case .user(let id):
            return "\(App.BaseUrl)/user/\(id)"
        case .weather(let day):
            return "\(App.BaseUrl)/weather/\(day.rawValue)"
        }
    }
}
```

## App Theme

```
struct AppThemeModel {
    let baseColor: UIColor
    let backgroundColor: UIColor
    let accentColor: UIColor
    let baseFont: UIFont
}

enum AppTheme {
    case dark
    case light

    var model: AppThemeModel {
      switch self {
      case .dark:
        return AppThemeModel(
          baseColor: .red
          backgroundColor: .darkRed
          accentColor: .yellow
          baseFont: .systemFontOfSize(12)
        )
      case .light:
        AppThemeModel(
          baseColor: .white
          backgroundColor: .gray
          accentColor: .blue
          baseFont: .systemFontOfSize(13)
        )
      }
    }
}


// During app init
var currentAppTheme = AppTheme.dark
```

## Binary Tree
```
indirect enum Tree<T> {
    case node(T, l: Tree, r: Tree)
    case leaf(T)

    var l: Tree? {
      switch self {
      case .node(_, l: let l, _):
        return l
      case .leaf(_):
        return nil
      }
    }

    var r: // equivalent implementation to l

    var value: T {
      switch self {
      case .node(let val, _, _):
        return val
      case .leaf(let val):
        return val
      }
    }
}

let tree = Tree.node(12, l: Tree.leaf(11),
                         r: Tree.node(34, l: Tree.leaf(34),
                                          r: Tree.leaf(55)))
```