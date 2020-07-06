---
layout: post
title: Swift - Switch, classtype, and cast using the "as" operator
date: '2014-10-01T10:29:00.001-07:00'
author: Scott McCoy
tags:
- Swift
modified_time: '2015-08-07T15:52:32.310-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-699836457445363595
blogger_orig_url: https://scotthmccoy.blogspot.com/2014/10/swift-switch-classtype-and-cast-using.html
---

<div class="p1"><span class="s1">func</span> determineMaintenanceRequirements(train: <span class="s2">Train</span>) -&gt; <span class="s3">String</span></div><div class="p1">{</div><div class="p1">&nbsp; &nbsp; <span class="s1">switch</span> train</div><div class="p1">&nbsp; &nbsp; {</div><div class="p1">&nbsp; &nbsp; &nbsp; &nbsp; <span class="s1">case</span> <span class="s1">let</span> maglev <span class="s1">as</span> <span class="s3">MaglevTrain</span>:</div><div class="p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class="s1">return</span> maglev.<span class="s4">referToSpecialist</span>()</div><div class="p2">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</div><div class="p1">&nbsp; &nbsp; &nbsp; &nbsp; <span class="s1">case</span> <span class="s1">let</span> steamtrain <span class="s1">as</span> <span class="s3">SteamTrain</span>:</div><div class="p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class="s1">return</span> steamtrain.<span class="s4">cleanFireBox</span>()</div><div class="p2">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</div><div class="p1">&nbsp; &nbsp; &nbsp; &nbsp; <span class="s1">default</span>:</div><div class="p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class="s1">return</span> train.<span class="s4">cleanPassengerCars</span>()</div><div class="p1">&nbsp; &nbsp; }</div><br /><div class="p1">}</div>