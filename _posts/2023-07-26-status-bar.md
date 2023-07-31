

# UIUserInterfaceStyle
A `UIViewController`'s `traitCollection.userInterfaceStyle` returns a `UIUserInterfaceStyle` that will tell you whether the app is in Dark Mode or Light Mode. You can also query `UIScreen.main.traitCollection.userInterfaceStyle` or listen for changes in `UIViewController.traitCollectionDidChange`.

These can be used to effectively respond to a user's desire to have apps conform to an OS-level setting for light/dark mode.

```
extension UIUserInterfaceStyle: CustomStringConvertible {
    public var description: String {
        switch self {
            case .unspecified: return "Unspecified"
            case .dark: return "Dark Mode (White Text on Black Background)"
            case .light: return "Light Mode (Black Text on White Background)"
        @unknown default:
            return "Unknown Default"
        }
    }
}
```

# UIStatusBarStyle
I generally associate the light and dark themes with light *mode* and dark *mode* so to me, the naming of UIStatusBarStyles felt a bit awkward at first: "lightContent" means the one you'd typically use for dark mode and "darkContent" means the one you'd typically use for light mode. However, since the status bar is typically translucent, the color of the *text* on the status bar matters a lot more than the bar's own color.

```
extension UIStatusBarStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .default:
            return "default"
            
        case .lightContent:
            return "lightContent (Dark Mode - White Text on Black Background)"
            
        case .darkContent:
            return "darkContent (Light Mode - Black Text on White Background)"
            
        @unknown default:
            return "Unknown Default"
        }
    }
}
```

Modo's approach for theming the status bar is:

* Set `UIUserInterfaceStyle` to `Light` in Info.plist. This locks the app into Light Mode; no matter what the OS-level setting for Light/Dark mode is, `someViewController.traitCollection.userInterfaceStyle` and `UIScreen.main.traitCollection.userInterfaceStyle` always return `.light`.
* Set `UIViewControllerBasedStatusBarAppearance` to `true` in Info.plist
* Have every view controller implement a `preferredStatusBarStyle` which returns a global theme's `UIStatusBarStyle` setting.
* Have an view anchored to the *top* of the safe area where the status bar would be that can be given a background color, effectively giving the status bar a configurable background color.

There is a bug(?) in iOS 13 and 16 where the statusBar's style will occasionally not update unless `childForStatusBarStyle` is implemented and `setNeedsStatusBarAppearanceUpdate()` is called. 

```
class WorkaroundNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    override var viewControllers: [UIViewController] {
        didSet { setNeedsStatusBarAppearanceUpdate() }
    }
}



