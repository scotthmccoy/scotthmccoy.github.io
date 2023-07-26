Some colors use a different color space so comparing them becomes difficult. For example, 

`UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)` is not equal to `UIColor.black` because the former uses `Color.RGBColorSpace` and the latter uses the greyscale one.

You can use `getHue` and some clever switch matching to determine equivalence:

```
extension UIColor {
    
    var brightness: CGFloat {
        return hsba.brightness
    }
    
    public var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b, a)
    }
    
    var name: String {
        let hsba = self.hsba
        switch self.hsba {
            case (hue: _, saturation: _, brightness: _, alpha:0):
                return "clear"
            case (hue:0, saturation:0, brightness: 0, alpha:1):
                return "black"
            case (hue:0, saturation:0, brightness: 1, alpha:1):
                return "white"
            default:
                return "\(hsba), \(self)"
        }
    }
}
```
