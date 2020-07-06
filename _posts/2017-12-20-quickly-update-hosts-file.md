---
layout: post
title: Quickly update hosts file
date: '2017-12-20T15:47:00.001-08:00'
author: Scott McCoy
tags: 
modified_time: '2017-12-20T15:47:48.361-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-6810350300987926340
blogger_orig_url: https://scotthmccoy.blogspot.com/2017/12/quickly-update-hosts-file.html
---

sudo bash -c 'echo -e "\n10.1.66.246\tqa-v2-i16-lmi.del-qa.openx.net" &gt;&gt; /etc/hosts'<br /><br />cat /etc/hosts<br /><br />sudo dscacheutil -flushcache