

```
import Foundation

//Structs
struct Shapes: Codable {
    let shapes: [Shape]
}

struct Square: Codable {
    let length: Double

    var area: Double {
        return length * length
    }
}

struct Rectangle: Codable {
    let width: Double
    let height: Double

    var area: Double {
        return width * height
    }
}



enum Shape: Codable {

    //Names of Shape's fields in json
    private enum ShapeFieldNames: String, CodingKey {
        case type
        case attributes
    }
    
    //Possible values for Shape's type field in json
    enum TypeFieldValues: String {
        case square
        case rectangle
    }
    
    //Possible contents of Shape - either a square or a rectangle
    case square(Square)
    case rectangle(Rectangle)
    
    var typeField: TypeFieldValues {
        switch self {
            case .square:
                return .square
            case .rectangle:
                return .rectangle
        }
    }

    //Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ShapeFieldNames.self)

        switch try container.decode(String.self, forKey: .type) {
            case TypeFieldValues.square.rawValue:
                self = .square(try container.decode(Square.self, forKey: .attributes))
            case TypeFieldValues.rectangle.rawValue:
                self = .rectangle(try container.decode(Rectangle.self, forKey: .attributes))
            default:
                fatalError("Unknown type")
        }
    }

    //Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ShapeFieldNames.self)

        switch self {
            case .square(let square):
                try container.encode(square, forKey: .attributes)
            case .rectangle(let rectangle):
                try container.encode(rectangle, forKey: .attributes)
        }

        try container.encode(typeField.rawValue, forKey: .type)
    }
}

//Fetch data from server
let responseStr = """
{
  "shapes" : [
    {
      "type" : "square",
      "attributes" : {
        "length" : 200
      }
    },
    {
      "type" : "rectangle",
      "attributes" : {
        "width" : 200,
        "height" : 300
      }
    }
  ]
}
"""
let responseData = Data(responseStr.utf8)


//Have JSONDecoder create a Feed object from
let shapes = try JSONDecoder().decode(Shapes.self, from:responseData)
print(shapes)

//Convert
let jsonEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted
let data = try jsonEncoder.encode(shapes)
let output = String(data:data, encoding: .utf8)!
print(output)

```


One thing I got from this exercise was that String enums' rawValues default to their key names:

```
enum StringEnum: String {
    case foo
    case bar
}

print(StringEnum.foo.rawValue) //"foo"
```
