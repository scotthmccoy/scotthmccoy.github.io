This ended up causing "failure to get launch progress" errors in my UI Tests. It could still be useful someday as a way to automate deletion of an app on a device (though there's probably a script that could do this prior to launch).

```
    func deleteApp(relaunch:Bool = true, file:StaticString=#file, line:UInt=#line) {
        //Close the app if it's launched
        XCUIApplication().terminate()

        //Find the app icon
        let icon = springboard.icons["VrtcalSDKInternalTestApp"]
        
        if icon.exists {
            //Tap and hold on the app icon
            icon.press(forDuration: 1.5)

            //Tap Remove App
            Thread.sleep(forTimeInterval:2.0)
            springboard.collectionViews.buttons["Remove App"].tap()
            
            //Tap Delete App
            Thread.sleep(forTimeInterval: 2.0)
            springboard.alerts.buttons["Delete App"].tap()
            
            //Tap Delete
            Thread.sleep(forTimeInterval: 2.0)
            springboard.alerts.buttons["Delete"].tap()
            
            Thread.sleep(forTimeInterval: 5.0)
        }
        
        if relaunch {
            XCUIApplication().launch()
        }
    }
```
