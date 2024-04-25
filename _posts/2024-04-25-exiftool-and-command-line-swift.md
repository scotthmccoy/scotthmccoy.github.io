This command line swift script consumes a text file containing output from exiftool and sorts photos by distance to provided GPS coordinates

```
#!/usr/bin/swift

// Example usage to sort photos by distance to Shibuya Scramble in Toyko, Japan
// exiftool -r . > exiftool.txt; gps exiftool.txt "35.659434326855525,139.70057327018296" > gps.out; say "DONE"

import Foundation
import RegexBuilder

// MARK: Data Structures
struct GPSInfo {
    let path: String
    let lat: Double
    let long: Double
    let distanceInMiles: Double
}

// MARK: Extensions
extension Result {
    func getError() -> Failure? {
        guard case let .failure(error) = self else {
            return nil
        }
        return error
    }
}

// MARK: Funcs
func printError(_ message: String) {
    fputs(message + "\n", stderr)
}

func getAndSplitFile(
    filename: String
) -> [String] {

    let result = Result {
        try String(contentsOfFile: filename, encoding: .utf8)
    }

    guard case let .success(contents) = result else {
        let error = result.getError()!
        print("error: \(error)")
        exit(1)
    }

    return contents
        .split(separator:"========")
        .map {
            String($0)
        }
}



func exifToolFieldExtract(
    exiftoolOutput: String, 
    fieldName: String
) -> String? {
    let gpsLatitudeMatcher = Regex {
        fieldName
        OneOrMore(.whitespace, .eager)
        ": "
        Capture {
            OneOrMore(.any, .reluctant)
        }
        "\n"
    }
    
    guard let (_, fieldValue) = exiftoolOutput.matches(of: gpsLatitudeMatcher).first?.output else {
        return nil
    }
    
    return String(fieldValue)
}



func extractFilenameAndGps(
    exiftoolOutput: String,
    referencePoint: (lat: Double, long: Double)
) -> GPSInfo? {

    let directory = exifToolFieldExtract(
        exiftoolOutput: exiftoolOutput,
        fieldName: "Directory"
    ) ?? ""

    let filename = exifToolFieldExtract(
        exiftoolOutput: exiftoolOutput,
        fieldName: "File Name"
    ) ?? "Unknown_File"

    let path = "\(directory)/\(filename)"

    let strLat = exifToolFieldExtract(
        exiftoolOutput: exiftoolOutput,
        fieldName: "GPS Latitude"
    ) ?? ""
    
    let strLong = exifToolFieldExtract(
        exiftoolOutput: exiftoolOutput,
        fieldName: "GPS Longitude"
    ) ?? ""

    let lat = gpsDegreesMinutesSecondsToDecimal(string: strLat) ?? 0.0
    let long = gpsDegreesMinutesSecondsToDecimal(string: strLong) ?? 0.0

    let distanceInMiles: Double
    if lat != 0.0 && long != 0.0 {
        distanceInMiles = degreesToMiles(
            gpsPoint1: referencePoint,
            gpsPoint2: (lat: lat, long: long)
        )
    } else {
        distanceInMiles = -1
    }

    return GPSInfo(
        path: path,
        lat: lat,
        long: long,
        distanceInMiles: distanceInMiles
    )
}

func gpsDegreesMinutesSecondsToDecimal(
    string: String
) -> Double? {
    var ret = 0.0
    
    // "118 deg 22' 53.46" W"
    let components = string
        .replacingOccurrences(of: "'", with: "")
        .replacingOccurrences(of: "\"", with: "")
        .components(separatedBy: " ")
    
    guard components.count == 5 else {
        return nil
    }
    
    guard let degrees = Double(components[0]) else {
        return nil
    }
    
    guard let minutes = Double(components[2]) else {
        return nil
    }
    
    guard let seconds = Double(components[3]) else {
        return nil
    }
    
    ret = degrees + minutes/60 + seconds/3600
    
    switch components[4] {
        case "E", "N":
            break
        case "W", "S":
            ret = ret * -1
        default:
            return nil
    }
    
    return ret
}

func degreesToMiles(
    gpsPoint1: (lat: Double, long: Double),
    gpsPoint2: (lat: Double, long: Double)
) -> Double {
    
    let degreesToRadians = Double.pi / 180
    let gpsPoint1 = (lat: gpsPoint1.lat * degreesToRadians, long: gpsPoint1.long * degreesToRadians)
    let gpsPoint2 = (lat: gpsPoint2.lat * degreesToRadians, long: gpsPoint2.long * degreesToRadians)
    
    return acos(
        sin(gpsPoint1.lat) * sin(gpsPoint2.lat) +
        cos(gpsPoint1.lat) * cos(gpsPoint2.lat) * cos(
            gpsPoint2.long - gpsPoint1.long
        )
    )*3958.8
}






// MARK: Script
// Validate input
guard CommandLine.arguments.count >= 3 else {
    printError("Usage: gps filename \"lat,long\"\n")
    exit(1)
}

let filename = CommandLine.arguments[1]
let latlong = CommandLine.arguments[2]

let arr = latlong.components(separatedBy: ",")
guard arr.count == 2 else {
    printError("Usage: gps filename \"lat,long\"\n")
    exit(1)
}

guard let lat = Double(arr[0]), 
let long = Double(arr[1]) else {
    printError("Usage: gps filename \"lat,long\"\n")
    exit(1)    
}

let output = getAndSplitFile(filename: filename)
    .compactMap {
        extractFilenameAndGps(
            exiftoolOutput: $0,
            referencePoint: (lat: lat, long: long)
        )
    }
    .sorted {
        $0.distanceInMiles < $1.distanceInMiles
    }
    .map {
        "\($0.path)\t\($0.lat)\t\($0.long)\t\($0.distanceInMiles)"
    }
    .joined(separator: "\n")

print(output)
```
