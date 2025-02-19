```

// If your program crashes, HackerRank doesn't show you debug output.
// Use this to print to stdout instead - your submission will fail,
// but you'll at least be able to debug.

func log(
    _ message: String,
    writeToHackerRankStdout: Bool = true,
    function: StaticString = #function,
    line: UInt = #line
) {
    let output = "\(function):\(line) \(message)"
    
    guard writeToHackerRankStdout else {
        print(output)  
        return
    }
    
    let path = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
    
    if !FileManager.default.fileExists(atPath: path) {
        FileManager.default.createFile(
            atPath: path, 
            contents: nil, 
            attributes: nil
        )
    }
    
    let fileHandle = FileHandle(forWritingAtPath: stdout)!
    defer {
        fileHandle.closeFile()
    }
    fileHandle.seekToEndOfFile()
    fileHandle.write("\(output)\n".data(using: .utf8)!)    
}

```
