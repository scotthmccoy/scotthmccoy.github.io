---
layout: post
title: How to delete all of Shiobhan's Music
date: '2018-12-13T16:53:00.002-08:00'
author: Scott McCoy
tags: 
modified_time: '2018-12-13T16:53:28.745-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-8513618533705241839
blogger_orig_url: https://scotthmccoy.blogspot.com/2018/12/how-to-delete-all-of-shiobhans-music.html
---

     ```
     find . -name "*iobhan*" -print0 | xargs -0 rm -r
     ```
