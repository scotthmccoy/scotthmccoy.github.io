Example Swift script:

```
import Foundation

// MARK: Script
// Validate input
guard CommandLine.arguments.count == 5 else {
  printError("Usage: ./ReplaceBetween startToken endToken replaceWith filePath\n")
  exit(1)
}

// Get args
let startToken = CommandLine.arguments[1]
let endToken = CommandLine.arguments[2]
var replaceWith = CommandLine.arguments[3]
let filePath = CommandLine.arguments[4]

// Get File Contents
var fileContents: String
do {
  fileContents = try getFileAsString(path: filePath)
} catch {
  printError("Error opening file: \(error)")
  exit(1)
}

// Replace string in file contents
replaceWith = "\n" + replaceWith.unescaped

let result = fileContents.replacedBetween(
  startToken: startToken,
  endToken: endToken,
  with: replaceWith
)

// Print results with no newline to prevent adding a newline to the end of the file
// swiftlint:disable:next log_usage
print(result, terminator: "")

// MARK: Utilities
func getFileAsString(path: String) throws -> String {
    return try String(contentsOfFile: path, encoding: .utf8)
}

func printError(_ message: String) {
    fputs(message + "\n", stderr)
}

extension String {
    func replacedBetween(startToken: String, endToken: String, with: String) -> String {

        // Find the tokens
        guard let startTokenRange = range(of: startToken), let endTokenRange = range(of: endToken) else {
            return self
        }

        // Get the bounds such that we will replace what's between them
        let fromBound = startTokenRange.upperBound
        let toBound = endTokenRange.lowerBound

        // Validate bounds
        let lowerOffset = fromBound.utf16Offset(in: self)
        let upperOffset = toBound.utf16Offset(in: self)

        guard lowerOffset <= upperOffset else {
            return self
        }

        // Create the replacement range and perform the replacement
        let range = fromBound..<toBound
        return replacingCharacters(in: range, with: with)
    }

    var unescaped: String {
        let entities = [
            "\0": "\\0",
            "\t": "\\t",
            "\n": "\\n",
            "\r": "\\r",
            "\"": "\\\"",
            "\'": "\\'"
        ]

        return entities
            .reduce(self) { (string, entity) in
                string.replacingOccurrences(of: entity.value, with: entity.key)
            }
            .replacingOccurrences(of: "\\\\(?!\\\\)", with: "", options: .regularExpression)
            .replacingOccurrences(of: "\\\\", with: "\\")
    }
}
```

Example CLI invocation:
`swift ./ReplaceBetween.swift "Foo" "Bar" "Baz" tmp.txt`

Example invocation from a Run Script Phase:
`xcrun --sdk macosx "$TOOLCHAIN_DIR/usr/bin/"swift ./ReplaceBetween.swift $startToken $endToken $output ../Classes/BuildEnvironment/BuildEnvironment.swift > tmp.txt`

Note the use of `$TOOLCHAIN_DIR`. This lets us use the same swift compiler that Xcode is using to compile.

