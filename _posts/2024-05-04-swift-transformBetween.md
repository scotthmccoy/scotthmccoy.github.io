---
title: 'Swift - Using RegexBuilder to make a transformBetween func'
---

Neat usage of RegexBuilder to transform all text between occurances of two tokens. Useful for transforming the contents of a tag, or in this case, compacting multi-line labels in app.debugDescription.

```
{% raw %}
import RegexBuilder
import Foundation

let debugDescription = """
 Attributes: Application, 0x159529070, pid: 4053, label: 'MyApp'
Element subtree:
 →Application, 0x159529070, pid: 4053, label: 'MyApp'
    Window (Main), 0x159529190, {{0.0, 0.0}, {414.0, 896.0}}
      Other, 0x159529550, {{0.0, 0.0}, {414.0, 896.0}}
        Other, 0x159529670, {{0.0, 0.0}, {414.0, 896.0}}
          Other, 0x1595292b0, {{0.0, 0.0}, {414.0, 896.0}}
            Image, 0x1595293d0, {{0.0, 0.0}, {414.0, 896.0}}, identifier: 'background'
              StaticText, 0x1590dd7f0, {{245.0, 814.0}, {149.0, 40.0}}, identifier: 'lblSdkVersionAndGps', label: 'SDK Version: 2.1.7-8
lat:0.0
long:0.0'
"""


extension String {
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

let printMe = debugDescription.transformBetween(startToken: "label: '", endToken: "'") {
    $0.replacingOccurrences(of: "\n", with: "\\n")
}

print(printMe)
{% endraw %}
```
