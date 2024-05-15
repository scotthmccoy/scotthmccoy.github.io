Given that pods can install code to the main bundle there no consistent way to get the version of a pod unless you include `Podfile.lock`.

```
// Print Adapter versions from Podfile.lock
if let path = Bundle.main.path(forResource: "Podfile.lock", ofType: nil),
let contents = try? String(contentsOfFile: path) {
    
    let filtered = contents.split(separator: "\n")
        .filter {
            $0.contains("- Vrtcal-") && 
            $0.contains("-Adapters") &&
            $0.contains(":") &&
            !$0.contains("Wrapper")
        }
        .joined(separator: "\n")
    
    
    appLogger.log("Adapters: \n\(filtered)")
} else {
    appLogger.log("Could not get Podfile.lock")
}
```

This prints:
```
Adapters: 
  - Vrtcal-AdMob-Adapters (1.0.4):
  - Vrtcal-AppLovin-Adapters (1.0.7):
  - Vrtcal-Fyber-FairBid-Adapters (1.0.4):
  - Vrtcal-IronSource-Adapters (1.1.2):
  - Vrtcal-Smaato-Adapters (1.0.1):
  - Vrtcal-Tapjoy-Adapters (1.0.3):
  - Vrtcal-Test-Adapters (1.0.0):
  - Vrtcal-Vungle-Adapters (1.0.4):
```
