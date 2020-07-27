---
layout: post
title: sips - resize images in bash
date: '2017-09-28T22:28:00.000-07:00'
author: Scott McCoy
tags: 
modified_time: '2017-09-28T22:28:00.250-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-1879022671200113115
blogger_orig_url: https://scotthmccoy.blogspot.com/2017/09/resize-images-in-bash.html
---

This will resize all jpegs into *at most* 640 on a side. Great for making thumbnails.

`sips -Z 640 *.jpg`
