---
layout: post
title: List xcodebuild variable for an xcodeproject
date: '2019-01-07T14:05:00.001-08:00'
author: Scott McCoy
tags: 
modified_time: '2019-01-07T14:22:36.658-08:00'
---

For xcodeproject:
`xcodebuild -project VrtcalSDK.xcodeproj/ -target "VrtcalSDK" -showBuildSettings`

For Workspace:
`xcodebuild -showBuildSettings -workspace Kurogo-iOS-Sandbox.xcworkspace -scheme 'Kurogo-iOS-Sandbox'`
