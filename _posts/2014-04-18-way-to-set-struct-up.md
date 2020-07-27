---
layout: post
title: Objc-C - Elegant struct syntax  
date: '2014-04-18T17:45:00.001-07:00'
author: Scott McCoy
tags: 
modified_time: '2014-04-18T17:45:14.333-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-4975679512362901571
blogger_orig_url: https://scotthmccoy.blogspot.com/2014/04/way-to-set-struct-up.html
---

```
 [self setFrame:(CGRect) {
    .origin = self.frame.origin,
    .size = newSize
}];
```
