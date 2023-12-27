Common Result Extensions:

```
// Keystroke saver.
// Allows a function returning Result<Void, Error> to `return .success()`
extension Result where Success == Void {
    public static func success() -> Self { .success(()) }
}

extension Result where Failure: Error {
    @discardableResult
    func logError() -> Self {
        if case let .failure(error) = self {
            DLog("Error: \(error)")
        }

        return self
    }
    func getSuccessOrHandleError(completion: (Failure) -> Void) -> Success? {
        switch self {
        case .success(let value):
            return value

        case .failure(let error):
            completion(error)
            return nil
        }
    }

    func getSuccessOrLogError(
        file: StaticString = #file,
        line: UInt = #line,
        column: UInt = #column,
        function: StaticString = #function
    ) -> Success? {
        switch self {
        case .success(let value):
            return value

        case .failure(let error):
            Log("Error: \(error)", file: file, line: line, column: column, function: function)
            return nil
        }
    }
}

extension Result {
    public func isSuccessful() -> Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    func getError() -> Failure? {
        guard case let .failure(error) = self else {
            return nil
        }
        return error
    }
}

// Note: This must be == because 
extension Result where Failure == Error {

    // Async version of init(catching: () throws -> Success)
    static func asyncCatching(
        body: () async throws -> Success
    ) async -> Self {

        do {
            return Self.success(try await body())
        } catch {
            return .failure(error)
        }
    }


}
```

