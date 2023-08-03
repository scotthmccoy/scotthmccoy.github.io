```
    func testExample() {

        let app = XCUIApplication()
        app.launch()
        
        let buttons = app.buttons
        buttons["btnBannerCreate"].tap()
        buttons["btnBannerLoad"].tap()
    
        Thread.sleep(forTimeInterval: 3.0)
        let webviews = app.otherElements["bannerBottom"].webViews.allElementsBoundByIndex
        XCTAssertEqual(webviews.count,1)
        
        guard let webView = webviews.first else {
            return
        }
        
        //Expect a single image to be visible in the webView
        let imagesInWebView = webView.images.allElementsBoundByIndex
        XCTAssertEqual(imagesInWebView.count,1)
        let catImage = imagesInWebView.first!
        XCTAssertEqual(catImage.label, "cats")
        
        buttons["btnBannerDestroy"].tap()
    }
```
