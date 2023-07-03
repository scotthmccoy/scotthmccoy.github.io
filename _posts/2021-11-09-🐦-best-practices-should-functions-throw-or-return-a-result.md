It's generally better practice to return a `Result` rather than  `throw` an error. The reason for this is **Strongly Typed Errors**. For example, compare the following which uses `throws`:

```
func foo<T: Decodable>() throws -> T {
    // Boilerplate Codable/API interaction code
}
```

To this one, which uses `Result`:
```
public enum CommunicateRequestError: Error, Equatable {
    case cancelled
    case unableToCreateRequest
    case codableHelperError(CodableHelperError)
    case invalidResponse
}

func foo<T: Decodable>() -> Result<T, CommunicateRequestError> {
    // Boilerplate Codable/API interaction code
}
```

The `Result` version:
1. Clearly communicates **exactly** what error was returned, if any
2. Lets us elegantly wrap or manipulate the error with `mapError`, validate the success value with `flatMap`, or alter the success value with `map`
2. Avoids having to wrap variable assignments in awkward do-try-catch blocks
3. Allows the use of function chaining to achieve a more reactive code style
