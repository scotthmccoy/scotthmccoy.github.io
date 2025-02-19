Remove Whitespace from start and end of string

`.trimmingCharacters(in: .whitespacesAndNewlines)`

Tokenize

`.components(separatedBy: " ")`

Convert to [Character], get first 4 chars (indicies 0, 1, 2 and 3):

`Array(string)[0..<4]`

Convert Character to Int

`char.wholeNumberValue!`

Replace Strings, Normal:

```
let aString = "This is my string"
let newString = aString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
```

Replace Strings, Regex: remove a minus sign at the beginning of the line

`processed = processed.replacingOccurrences(of: "^\\-", with: "", options: .regularExpression)`




Common String Extensions:
```
extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

extension String {
    
    public func numberOfOccurances(_ str:String) -> Int {
        let ret = self.components(separatedBy:str).count - 1
        return ret
    }

    func match(_ regex: String) -> [[String]] {
        let nsString = self as NSString
        
        return (
            try? NSRegularExpression(
                pattern: regex,
                options: []
            )
        )?.matches(
            in: self,
            options: [],
            range: NSMakeRange(0, nsString.length)
        )
        .map { match in
            (0..<match.numberOfRanges)
            .map {
                match
                .range(at: $0)
                .location == NSNotFound ? "" : nsString.substring(
                    with: match.range(at: $0)
                )
            }
        } ?? []
    }

    public func groupMatch(regex:String, groupNumber:Int) -> String? {
        let regex = try! NSRegularExpression(pattern:regex)
        
        let range = NSRange(location:0, length:self.count)
        guard let match = regex.firstMatch(in:self, range:range) else {
            return nil
        }
        
        guard let groupRange = Range(match.range(at:groupNumber), in:self) else {
            return nil
        }
            
        let ret = self[groupRange]
        return String(ret)
    }
    
    public func substring(to:Int) -> String {
        let startIndex = self.startIndex
        let endIndex = index(self.startIndex, offsetBy:min(to, self.count))
        let substring = self[startIndex ..< endIndex]
        let ret = String(substring)
        return ret
    }
    
    public func substring(from:String, to:String? = nil) -> String? {
        guard let startIndex = self.endIndex(of:from) else {
            return nil
        }

        let substr = self[startIndex..<self.endIndex]
        
        if let unwrappedTo = to {
            guard let endIndex = substr.index(of:unwrappedTo) else {
                return nil
            }

            let ret = String(substr[substr.startIndex..<endIndex])
            return ret
        } else {
            return String(substr)
        }
    }
    
    @available(iOS 16, *)
    func transformBetween(
        startToken: String,
        endToken: String,
        transform: (String) -> (String)
    ) -> String {
        
        let matcher = Regex {
            startToken
            Capture {
                OneOrMore(.any, .reluctant)
            }
            endToken
        }

        return self.replacing(matcher, with: { match in
            return startToken + transform(String(match.output.1)) + endToken
        })
    }
}
```

Using that `match` func to tokenize a string:
```
let result = "foo:123,bar:456,baz:567".match("(.*?):([0-9]+)(,|$)")
```
Output:
```
[["foo:123,", "foo", "123", ","], ["bar:456,", "bar", "456", ","], ["baz:567", "baz", "567", ""]]
```

Though you'd be better off with:
```
let arr = "foo:123,bar:456,baz:567"
    .components(separatedBy: ",")
    .map {
        $0.components(separatedBy: ":")
    }
print(arr)
```

Output:
```
[["foo", "123"], ["bar", "456"], ["baz", "567"]]
```
