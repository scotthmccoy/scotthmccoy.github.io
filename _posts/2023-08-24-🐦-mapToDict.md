This lovely extension allows a more functional approach to transforming dictionaries. 

```
import Foundation

enum ParseError: Error {
    case uuidParseError
}

let startingDict = [
    "E621E1F8-C36C-495A-93FC-0C247A3E6E5A": "foo",
    "E621E1F8-C36C-495A-93FC-0C247A3E6E5B": "bar",
    "E621E1F8-C36C-495A-93FC-0C247A3E6E5C": "baz"
]

extension Sequence {
    public func mapToDict<Key: Hashable, Value>(
        transform: (Iterator.Element) -> (Key, Value)?
    ) -> [Key:Value] {
        let tuples = self.compactMap(transform)
        return Dictionary(uniqueKeysWithValues: tuples)
    }
}

let dict: [UUID:String] = startingDict.mapToDict { tuple in
    
    // Convert string to UUID
    guard let uuid = UUID(uuidString: tuple.key) else {
        return nil
    }
    
    // uppercase the value
    let name = tuple.value.uppercased()
    
    return (uuid, name)
}


print(dict)
```
