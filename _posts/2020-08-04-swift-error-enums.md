
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
