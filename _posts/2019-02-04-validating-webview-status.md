
Saving this in case I need to validate a webview more carefully. If we trust that the presence of an image named "cats" is sufficient to determine that the banner loaded then everything after "Validate the Banner" is superfluous.

```
  func testBanner() {

        //Launch the app
        let app = XCUIApplication()
        app.launch()
        
        //Tap create and load
        let buttons = app.buttons
        buttons["btnBannerCreate"].tap()
        buttons["btnBannerLoad"].tap()
        
        buttons["btnBannerCreate"].tap()
        buttons["btnBannerLoad"].tap()
        
        //Wait for the banner to load and the cat image to appear
        waitForExists(element:app.images["cats"])
        
        //Validate the banner:
        //Expect a single VrtcalBanner with the accessibility ID of "bannerBottom", and get all its child webviews.
        let webviews = app.otherElements["bannerBottom"].webViews.allElementsBoundByIndex
        XCTAssertEqual(webviews.count,1)
        guard let webView = webviews.first else {
            return
        }
        
        //Expect a single visible image in the webView.
        //The tracking pixel is set to 0x0, so it will not be picked up by XCUITest.
        let imagesInWebView = webView.images.allElementsBoundByIndex
        XCTAssertEqual(imagesInWebView.count,1)
        
        //Get the image and expect its alt text to be "cats"
        let catImage = imagesInWebView.first!
        XCTAssertEqual(catImage.label, "cats")
        catImage.tap()
        
        //Return to the app
        app.activate()
        
        //Destroy the banner
        buttons["btnBannerDestroy"].tap()
    }
```
