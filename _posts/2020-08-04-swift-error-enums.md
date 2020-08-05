---
layout: post
title: 🐦 Swift - Error Enums
date: 2020-08-04 21:57 -0700
---

```
enum SimulatorFetchError: Error, CustomStringConvertible {
    case generalError(message: String)
    case invalidState
    case serverError(code: UInt)


    var description: String {
        switch self {
            case .generalError(let message):
                return ("Error: \(message)")
            case .invalidState:
                return "Error: Invalid State"
            case .serverError(let code):
                return "Server Error: \(code)"
        }
    }
}
```
