---
layout: post
title: Reset all simulators
date: '2019-08-13T11:39:00.001-07:00'
author: Scott McCoy
tags: 
modified_time: '2019-08-13T11:42:01.155-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-7754839385167563385
blogger_orig_url: https://scotthmccoy.blogspot.com/2019/08/reset-all-simulators.html
---

#Kill all simulators<br />ps -efw | grep Simulator.app | grep -v grep | awk '{print $2}' | xargs kill<br /><br />#Get a list of all installed simulators and extract their UUID, then run "xcrun simctl erase" on each UUID<br />xcrun simctl list devices | grep -v unavailable | grep -o '[0-9A-F]\{8\}-[0-9A-F]\{4\}-[0-9A-F]\{4\}-[0-9A-F]\{4\}-[0-9A-F]\{12\}' | xargs -I {} xcrun simctl erase "{}"<br /><br /><br />Note the use of grep -o, which only prints the portion that matched.