---
layout: post
title: Cocoapods CLI Tricks
date: 2021-02-18 13:54 -0800
---

Search for pods:

`arch -x86_64 pod search mopub-ios-sdk`

```
-> mopub-ios-sdk (5.16.0)
   The Official MoPub Client SDK allows developers to easily monetize their apps by showing banner, interstitial, and native ads.
   pod 'mopub-ios-sdk', '~> 5.16.0'
   - Homepage: https://github.com/mopub/mopub-ios-sdk
   - Source:   https://github.com/mopub/mopub-ios-sdk.git
   - Versions: 5.16.0, 5.15.0, 5.14.1, 5.14.0, 5.13.1, 5.13.0, 5.12.1, 5.12.0, 5.11.0, 5.10.0, 5.9.0, 5.8.0, 5.7.1, 5.7.0, 5.6.0, 5.5.0,
   5.4.1, 5.4.0, 5.3.0, 5.2.0, 5.1.0, 5.0.0, 4.20.1, 4.20.0, 4.19.0, 4.18.0, 4.17.0, 4.16.1, 4.16.0, 4.15.0, 4.14.0, 4.13.1, 4.13.0,
   4.12.0, 4.11.1, 4.11.0, 4.10.1, 4.10.0, 4.9.1, 4.9.0, 4.8.0, 4.7.0, 4.6.0, 4.5.1, 4.5.0, 4.4.0, 4.3.0, 4.2.0, 4.1.0, 4.0.0, 3.13.0,
   3.12.0, 3.10.0, 3.9.0, 3.8.0, 3.7.0, 3.6.0, 3.5.0, 3.4.0, 3.3.0, 3.1.0, 2.4.0, 2.3.0, 2.2.0, 2.1.0 [trunk repo]
   - Subspecs:
     - mopub-ios-sdk/MoPubSDK (5.16.0)
     - mopub-ios-sdk/Core (5.16.0)
     - mopub-ios-sdk/NativeAds (5.16.0)

-> gjg-mopub-ios-sdk (5.7.1.3)
   The Official MoPub Client SDK allows developers to easily monetize their apps by showing banner, interstitial, and native ads.
   pod 'gjg-mopub-ios-sdk', '~> 5.7.1.3'
   - Homepage: https://github.com/arkenthera/gjg-mopub-ios-sdk
   - Source:   https://github.com/arkenthera/gjg-mopub-ios-sdk.git
   - Versions: 5.7.1.3, 5.7.1 [trunk repo]
   - Subspecs:
     - gjg-mopub-ios-sdk/MoPubSDK (5.7.1.3)
:
```



Show podspec files for pods:

`arch -x86_64 pod spec cat "^mopub-ios-sdk$" --regex --show-all`

```
1: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.16.0/mopub-ios-sdk.podspec.json
2: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.15.0/mopub-ios-sdk.podspec.json
3: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.14.1/mopub-ios-sdk.podspec.json
4: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.14.0/mopub-ios-sdk.podspec.json
5: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.13.1/mopub-ios-sdk.podspec.json
6: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.13.0/mopub-ios-sdk.podspec.json
7: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.12.1/mopub-ios-sdk.podspec.json
8: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.12.0/mopub-ios-sdk.podspec.json
9: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.11.0/mopub-ios-sdk.podspec.json
10: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.10.0/mopub-ios-sdk.podspec.json
11: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.9.0/mopub-ios-sdk.podspec.json
12: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.8.0/mopub-ios-sdk.podspec.json
13: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.7.1/mopub-ios-sdk.podspec.json
14: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.7.0/mopub-ios-sdk.podspec.json
15: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.6.0/mopub-ios-sdk.podspec.json
16: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.5.0/mopub-ios-sdk.podspec.json
17: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.4.1/mopub-ios-sdk.podspec.json
18: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.4.0/mopub-ios-sdk.podspec.json
19: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.3.0/mopub-ios-sdk.podspec.json
20: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.2.0/mopub-ios-sdk.podspec.json
21: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.1.0/mopub-ios-sdk.podspec.json
22: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/5.0.0/mopub-ios-sdk.podspec.json
23: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.20.1/mopub-ios-sdk.podspec.json
24: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.20.0/mopub-ios-sdk.podspec.json
25: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.19.0/mopub-ios-sdk.podspec.json
26: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.18.0/mopub-ios-sdk.podspec.json
27: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.17.0/mopub-ios-sdk.podspec.json
28: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.16.1/mopub-ios-sdk.podspec.json
29: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.16.0/mopub-ios-sdk.podspec.json
30: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.15.0/mopub-ios-sdk.podspec.json
31: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.14.0/mopub-ios-sdk.podspec.json
32: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.13.1/mopub-ios-sdk.podspec.json
33: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.13.0/mopub-ios-sdk.podspec.json
34: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.12.0/mopub-ios-sdk.podspec.json
35: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.11.1/mopub-ios-sdk.podspec.json
36: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.11.0/mopub-ios-sdk.podspec.json
37: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.10.1/mopub-ios-sdk.podspec.json
38: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.10.0/mopub-ios-sdk.podspec.json
39: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.9.1/mopub-ios-sdk.podspec.json
40: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.9.0/mopub-ios-sdk.podspec.json
41: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.8.0/mopub-ios-sdk.podspec.json
42: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.7.0/mopub-ios-sdk.podspec.json
43: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.6.0/mopub-ios-sdk.podspec.json
44: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.5.1/mopub-ios-sdk.podspec.json
45: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.5.0/mopub-ios-sdk.podspec.json
46: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.4.0/mopub-ios-sdk.podspec.json
47: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.3.0/mopub-ios-sdk.podspec.json
48: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.2.0/mopub-ios-sdk.podspec.json
49: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.1.0/mopub-ios-sdk.podspec.json
50: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/4.0.0/mopub-ios-sdk.podspec.json
51: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.13.0/mopub-ios-sdk.podspec.json
52: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.12.0/mopub-ios-sdk.podspec.json
53: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.10.0/mopub-ios-sdk.podspec.json
54: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.9.0/mopub-ios-sdk.podspec.json
55: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.8.0/mopub-ios-sdk.podspec.json
56: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.7.0/mopub-ios-sdk.podspec.json
57: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.6.0/mopub-ios-sdk.podspec.json
58: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.5.0/mopub-ios-sdk.podspec.json
59: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.4.0/mopub-ios-sdk.podspec.json
60: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.3.0/mopub-ios-sdk.podspec.json
61: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/3.1.0/mopub-ios-sdk.podspec.json
62: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/2.4.0/mopub-ios-sdk.podspec.json
63: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/2.3.0/mopub-ios-sdk.podspec.json
64: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/2.2.0/mopub-ios-sdk.podspec.json
65: /Users/scottmccoy/.cocoapods/repos/trunk/Specs/9/8/0/mopub-ios-sdk/2.1.0/mopub-ios-sdk.podspec.json
Which spec would you like to print [1-65]? 
65
{
  "name": "mopub-ios-sdk",
  "version": "2.1.0",
  "summary": "The Official MoPub Client SDK allows developers to easily monetize their apps by showing banner, interstitial, and native ads.",
  "description": "                    MoPub is a hosted ad serving solution built specifically for mobile publishers.\n                    Grow your mobile advertising business with powerful ad management, optimization \n                    and reporting capabilities, and earn revenue by connecting to the world's largest \n                    mobile ad exchange. \n\n                    To learn more or sign up for an account, go to http://www.mopub.com. \n",
  "homepage": "https://github.com/mopub/mopub-ios-sdk",
  "license": {
    "type": "New BSD",
    "file": "LICENSE"
  },
  "authors": {
    "MoPub": "support@mopub.com"
  },
  "social_media_url": "http://twitter.com/mopub",
  "platforms": {
    "ios": "5.0"
  },
  "source": {
    "git": "https://github.com/mopub/mopub-ios-sdk.git",
    "tag": "2.1.0"
  },
  "frameworks": [
    "CoreGraphics",
    "CoreLocation",
    "CoreTelephony",
    "EventKit",
    "EventKitUI",
    "Foundation",
    "MediaPlayer",
    "QuartzCore",
    "SystemConfiguration",
    "UIKit"
  ],
  "weak_frameworks": [
    "AdSupport",
    "StoreKit"
  ],
  "requires_arc": false,
  "default_subspecs": [
    "MoPubSDK"
  ],
  "subspecs": [
    {
      "name": "MoPubSDK",
      "source_files": "MoPubSDK/*.{h,m}",
      "resources": "MoPubSDK/**/*.{png,bundle,xib,nib}",
      "dependencies": {
        "mopub-ios-sdk/MoPubSDK Internal": [

        ],
        "mopub-ios-sdk/Native Ads": [

        ]
      }
    },
    {
      "name": "MoPubSDK Internal",
      "source_files": "MoPubSDK/Internal/**/*.{h,m}",
      "dependencies": {
        "mopub-ios-sdk/MoPubSDK": [

        ]
      }
    },
    {
      "name": "Native Ads",
      "source_files": "MoPubSDK/Native Ads/*.{h,m}",
      "dependencies": {
        "mopub-ios-sdk/MoPubSDK": [

        ],
        "mopub-ios-sdk/Native Ads Internal": [

        ]
      }
    },
    {
      "name": "Native Ads Internal",
      "source_files": "MoPubSDK/Native Ads/Internal/**/*.{h,m}",
      "dependencies": {
        "mopub-ios-sdk/Native Ads": [

        ]
      }
    },
    {
      "name": "iAd",
      "source_files": "AdNetworkSupport/iAd/*.{h,m}",
      "dependencies": {
        "mopub-ios-sdk/MoPubSDK": [

        ]
      },
      "frameworks": "iAd"
    },
    {
      "name": "AdMob",
      "source_files": "AdNetworkSupport/GoogleAdMob/*.{h,m}",
      "dependencies": {
        "Google-Mobile-Ads-SDK": [
          "~> 6.6.1"
        ],
        "mopub-ios-sdk/MoPubSDK": [

        ]
      }
    },
    {
      "name": "Chartboost",
      "source_files": "AdNetworkSupport/Chartboost/*.{h,m}",
      "dependencies": {
        "ChartboostSDK": [
          "~> 4.1.0"
        ],
        "mopub-ios-sdk/MoPubSDK": [

        ]
      }
    },
    {
      "name": "Greystripe",
      "source_files": "AdNetworkSupport/Greystripe/*.{h,m}",
      "dependencies": {
        "GreystripeSDK": [
          "~> 4.2.3"
        ],
        "mopub-ios-sdk/MoPubSDK": [

        ]
      }
    },
    {
      "name": "AdColony",
      "source_files": "AdNetworkSupport/AdColony/*.{h,m}",
      "dependencies": {
        "AdColony": [
          "~> 2.2.4"
        ],
        "mopub-ios-sdk/MoPubSDK": [

        ]
      }
    }
  ]
}
scottmccoy@scotts-mbp-m1 ~ % 
```
