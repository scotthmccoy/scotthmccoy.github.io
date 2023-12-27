By default, URLSession.dataTask’s URLSessionConfiguration uses HTTPCookieStorage.shared and adds all cookies that have been written to it. 

You can copy cookies out of a browser:

```
let dataStore = webview.configuration.websiteDataStore
dataStore.httpCookieStore.getAllCookies({ cookies in
    cookies.forEach({ (cookie) in
        HTTPCookieStorage.shared.setCookie(cookie)
    })

    completion?()
})
```

And copy cookies from `HTTPCookieStorage.shared` into browsers using javascript:
```
HTTPCookieStorage.shared.cookies?.forEach({ (cookie) in
    webview.configuration.websiteDataStore.httpCookieStore.setCookie(cookie, completionHandler: nil)
})
```

It might be the case that importing cookies into a WKWebView also requires doing some javascript, but that seems redundant.

