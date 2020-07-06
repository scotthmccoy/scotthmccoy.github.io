---
layout: post
title: Bash - Find large directories
date: '2015-07-18T12:08:00.001-07:00'
author: Scott McCoy
tags: 
modified_time: '2020-01-09T11:35:16.593-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-6547083840541904006
blogger_orig_url: https://scotthmccoy.blogspot.com/2015/07/osx-find-large-folders.html
---

cd /<br />du -k |  awk '$1 &gt; 500000' | sort -nr