I used [Hear](https://github.com/sveinbjornt/hear?tab=readme-ov-file) very effectively to transcribe audio. It didn't appear to go any faster when it was audio, but here's how to convert a video to mp4 audio anyways:
```
brew install ffmpeg
ffmpeg -i input.mp4 -vn -acodec copy output.mp4
```

Note: I couldn't install Hear to `/usr/local/bin/` without disabling security and rebooting, so I dropped it into `~/Documents/hear` along with the swift script below.

Example invocation:

```
./hear -T -d -i /video.m4v > transcribed_text.txt
```

The `-T` flag adds timestamps

The `-d` flag makes it use on-device speech recognition:

```
Only use on-device offline speech recognition. The default is to use whatever
the macOS Speech Recognition API thinks is best, which may include sending data
to Apple servers. When on-device is not enabled, there may be a hard limit to
the length of audio that can be transcribed in a single session. As of writing
(2025) this seems to be about 500 characters or so.
```

And `-i` specifies the input file.


I wrote this this swift script to wrap the peculiarities of the hear command, convert whole directories and process the output into a tabbed format that is easier to add into google sheets.

```
#!/usr/bin/swift

import Foundation

// Validate input
guard CommandLine.arguments.count >= 2 else {
    printError("Usage:")
    printError("hear directory")
    printError("or")
    printError("hear file")
    exit(1)
}

// Extract args
let pathArg = CommandLine.arguments[1]

let isDirectory: Bool
do {
    isDirectory = try FileManager.default.isDirectory(atPath: pathArg)
    
    print("is directory: \(isDirectory)")
    
    if isDirectory {
        let files = try FileManager.default.contentsOfDirectory(atPath: pathArg)

        for file in files {
            
            let fullPath = "\(pathArg)/\(file)"
            
            // Determine file type
            let output = try shell("file \(fullPath)")
            
            // Bail if it's text
            guard !output.contains("ASCII text") else {
                // print("skipping \(file)")
                continue
            }
            
            // Convert it
            convertFile(path: fullPath)
        }
        
    } else {
        convertFile(path: pathArg)
    }
} catch {
    printError("error: \(error)")
    exit(1)
}










// MARK: Funcs
func convertFile(path: String) {
    print("converting \(path)...")
    
    // Run the hear command
    let hearCommandBase = "~/Documents/hear/hear-0.6/hear -T -d -i"
    let command = "\(hearCommandBase) \(path) 2>&1"
    
    var transcript: String
    do {
        transcript = try shell(command)
    } catch {
        printError("error: \(error)")
        return
    }

    
    // Split the output by newline
    let lines = transcript.split(separator: "\n")

    // Walk the array
    let output = lines.reduce("") { (accumulator, item) in

        // For timestamp lines, replace the separator with a tab and add a tab at the end
        if item.contains(" --> ") {
            let tabbed = item.replacingOccurrences(of: " --> ", with: "\t")
            return accumulator + tabbed + "\t"
        } 

        // For transcript lines, just add it to the end and add a newline
        return accumulator + item + "\n"
    }


    // Write to file
    let writePath = path + ".txt"
    let writeUrl = URL(fileURLWithPath: writePath)

    do {
        try output.write(to: writeUrl, atomically: true, encoding: .utf8)
    } catch {
        printError("Error writing output to file: \(error.localizedDescription)")
    }
}


// MARK: Utility Funcs
func printError(_ message: String) {
    fputs(message + "\n", stderr)
}

@discardableResult // Add to suppress warnings when you don't want/need a result
func shell(_ command: String) throws -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.executableURL = URL(fileURLWithPath: "/bin/zsh") //<--updated
    task.standardInput = nil

    try task.run() //<--updated
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}


// MARK: Extensions
extension FileManager {
    
    func isDirectory(atPath path: String) throws -> Bool {
        switch try attributesOfItem(atPath: path)[.type] as? FileAttributeType {
        case .typeDirectory:
            true
            
        default:
            false
        }
    }
}
```

