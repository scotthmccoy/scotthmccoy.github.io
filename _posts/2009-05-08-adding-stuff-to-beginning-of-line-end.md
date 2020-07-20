---
layout: post
title: Adding stuff to beginning of line & end of line in a multi-line file in unix
date: '2009-05-08T09:34:00.000-07:00'
author: Unknown
tags: 
modified_time: '2009-05-08T09:36:22.614-07:00'
---

Add to beginning of line:

`sed 's/^/string_to_prepend_with/' file_list`

Add to end of line:

`sed 's/$/string_to_append/g' file_list`