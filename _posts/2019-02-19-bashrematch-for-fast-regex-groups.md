---
layout: post
title: BASH_REMATCH for fast regex groups
date: '2019-02-19T16:51:00.001-08:00'
author: Scott McCoy
tags: 
modified_time: '2019-02-19T16:51:00.133-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-5959102699516856350
blogger_orig_url: https://scotthmccoy.blogspot.com/2019/02/bashrematch-for-fast-regex-groups.html
---

<span style="white-space: pre;">   </span>if [[ $contents =~ (.+img)(.+) ]]<br /><span style="white-space: pre;">   </span>then<br /><span style="white-space: pre;">    </span>echo "${BASH_REMATCH[1]} alt=\"$alt_text\"${BASH_REMATCH[2]}" &gt; $file<br /><span style="white-space: pre;">   </span>fi