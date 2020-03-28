---
layout: post
title: Fix corrupted path with hash command
date: '2020-01-27T14:03:00.000-08:00'
author: Scott McCoy
tags: 
modified_time: '2020-01-27T14:03:14.767-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-2286352374354687629
blogger_orig_url: https://scotthmccoy.blogspot.com/2020/01/hash-command.html
---

Sometimes when installing new versions of software, the path that bash has saved gets corrupted. Running the hash command on that command can fix it, or just running hash -r


```
[lunchvote@server /]$ node
-bash: /usr/local/bin/node: No such file or directory
hash node
[lunchvote@server /]$ node --version
v10.18.1
```