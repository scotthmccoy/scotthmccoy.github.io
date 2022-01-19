---
layout: post
title: 🐙🐈 Github - Click all Load Diff Buttons
date: '2018-06-06T13:31:00.001-07:00'
author: Scott McCoy
tags: 
modified_time: '2018-06-18T13:33:36.483-07:00'
---

In Chrome, type `command+opt+J`, then paste the following into the console and hit enter

```
document.querySelectorAll('.load-diff-button').forEach(node => node.click());
document.querySelectorAll('.show-outdated-button').forEach(node => node.click())
```
