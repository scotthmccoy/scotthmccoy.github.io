---
layout: post
title: Spotlight uses the mdfind utility?
date: '2014-07-15T14:19:00.000-07:00'
author: Scott McCoy
tags: 
modified_time: '2014-07-15T14:19:59.749-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-6816199231389621309
blogger_orig_url: https://scotthmccoy.blogspot.com/2014/07/spotlight-uses-mdfind-utility.html
---

<div class="p1"><span style="font-family: Courier New, Courier, monospace;">mdfind finds all the dSYM files on my computer:</span></div><div class="p1"><span style="font-family: Courier New, Courier, monospace;"><br /></span></div><div class="p1"><span style="font-family: Courier New, Courier, monospace;">Administrations-MacBook-Pro:resymbolicate Scott$ <b>mdfind</b> "com_apple_xcode_dsym_uuids == *"</span></div><div class="p1"><span style="font-family: Courier New, Courier, monospace;">/Users/Scott/Desktop/resymbolicate/Grindr Xtra.app.dSYM</span></div><div class="p1"><span style="font-family: Courier New, Courier, monospace;">/Users/Scott/Downloads/Grindr Xtra.app.dSYM</span></div><div class="p1"><span style="font-family: Courier New, Courier, monospace;">/Users/Scott/Library/Developer/Xcode/DerivedData/NBFIOSCore-bvlcbrbqdltyowhkobyjjencwfex/Build/Products/Debug-iphonesimulator/Grindr Xtra.app.dSYM</span></div><div class="p1"><span style="font-family: Courier New, Courier, monospace;">/Users/Scott/Desktop/resymbolicate/Grindr.app.dSYM</span></div><div class="p1"><span style="font-family: Courier New, Courier, monospace;">/Users/Scott/Library/Developer/Xcode/DerivedData/NBFIOSCore-bvlcbrbqdltyowhkobyjjencwfex/Build/Products/Debug-iphonesimulator/GrindrSystemTests.xctest.dSYM</span></div><br /><div class="p1"><span style="font-family: Courier New, Courier, monospace;">/Users/Scott/Library/Developer/Xcode/DerivedData/NBFIOSCore-bvlcbrbqdltyowhkobyjjencwfex/Build/Products/Debug-iphonesimulator/Grindr.app.dSYM</span></div>