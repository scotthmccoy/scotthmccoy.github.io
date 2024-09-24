---
title: 'CLI to Uninstall an App'
---

This is possible with the following brews:

```
brew install libimobiledevice
brew install ideviceinstaller

ideviceinstaller --uninstall com.vrtcal.TwitMore
```

The [idevicediagnostics](https://docs.libimobiledevice.org/libimobiledevice/latest/) brew also allows you to restart a device, take a screenshot, and other helpful things:
`idevicediagnostics -u 41b543cd46ffe56c6d95992a3407182e69d63c5c restart`

