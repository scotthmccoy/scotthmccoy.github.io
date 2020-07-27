---
layout: post
title: sips - Change image format and resize
date: '2019-02-20T15:18:00.001-08:00'
author: Scott McCoy
tags: 
modified_time: '2019-02-20T15:18:32.936-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-6250473268298281020
blogger_orig_url: https://scotthmccoy.blogspot.com/2019/02/more-sips-change-format-and-resize.html
---

## Change image format
```
sips -s format png 300_250.gif --out 300_250.png
sips -s format png 360_640.jpg --out 360_640.png
sips -s format png 640_360.jpg --out 640_360.png
sips -s format png 1280_720.jpg --out 1280_720.png
```

## Resize
```
sips -z 720 1280 1280_720.png
sips -z 250 300 300_250.png
sips -z 50 320 320_50.png
sips -z 640 360 360_640.png
sips -z 360 640 640_360.png
sips -z 90 768 768_90.png
```
