---
layout: post
title: Alternative to border:1px solid red
date: '2009-10-20T09:40:00.000-07:00'
author: Unknown
tags: 
modified_time: '2009-10-20T09:44:31.490-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-4629279673896287896
blogger_orig_url: https://scotthmccoy.blogspot.com/2009/10/alternative-to-border1px-solid-red.html
---

Borders add to the width and height, so use a BG instead. This obscures whatever's behind it, so use opacity too:<br /><br />background:blue;<br />opacity:0.4;<br /><br /><br />Note to self: opacity works on every browser that lightboxes work on, so why can't we use a 40% opacity div with a black background to create a dropshadow?