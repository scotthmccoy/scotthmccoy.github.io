---
layout: post
title: Flyweight Design Pattern, "Hydration"
date: '2014-08-04T11:15:00.000-07:00'
author: Scott McCoy
tags: 
modified_time: '2014-09-12T12:24:20.658-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-1150038348477465156
blogger_orig_url: https://scotthmccoy.blogspot.com/2014/08/flyweight-imagine-situation-like-word.html
---

<b>Flyweight</b> - Imagine a situation like a word doc where you'd want to have an object in memory for every glyph in the doc. A way to improve memory efficiency is to accept that most of these objects are exactly the same (26 lower and upper case letters) save for their location, so just keep a table of object to location pairings.<br /><br />This is sort of like the radix sort of memory management - you know you can expect there to be a lot of repetition in your data, so you take advantage of that. :)<br /><br /><br /><b>Hydrate</b> - A Hibernate term that is encroaching into the common lexicon. Dehydrated means like a Core Data fault object and Hydration means to expand it into a full object.<br /><br />