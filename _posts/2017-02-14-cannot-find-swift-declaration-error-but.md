---
layout: post
title: 🐦 Cannot find swift declaration error, but still compiles
date: '2017-02-14T17:10:00.001-08:00'
author: Scott McCoy
tags: 
modified_time: '2017-02-14T17:10:54.039-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-96089827048284986
blogger_orig_url: https://scotthmccoy.blogspot.com/2017/02/cannot-find-swift-declaration-error-but.html
---

This seems like it's an issue with Framework search paths not being able to find the .swiftmodule files when a relative path is used.

This guy discovered that spaces in the path make it break: https://forums.developer.apple.com/thread/46904

But it seems like relative paths *at all* cause the issue.
