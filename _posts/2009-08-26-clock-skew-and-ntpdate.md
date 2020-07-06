---
layout: post
title: clock skew and ntpdate
date: '2009-08-26T10:29:00.000-07:00'
author: Unknown
tags: 
modified_time: '2009-08-26T10:30:39.993-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-2789770376621947731
blogger_orig_url: https://scotthmccoy.blogspot.com/2009/08/clock-skew-and-ntpdate.html
---

I noticed that the clock on linuxdev2 was about 25 minutes off and decided to correct it. Turns out there's a unix command that does this for you (naturally).<br /><br /><br />ntpdate 0.north-america.pool.ntp.org