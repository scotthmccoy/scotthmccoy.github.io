---
layout: post
title: Position relative undefined for table cells
date: '2009-11-06T09:51:00.000-08:00'
author: Unknown
tags: 
modified_time: '2009-11-06T09:52:22.952-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-51345998475824373
blogger_orig_url: https://scotthmccoy.blogspot.com/2009/11/htmlcss-quirk.html
---

position:relative is undefined for table cells. This means that if you want an absolutely positioned element inside a table cell you have to use a wrapper div that has position:relative on it.
