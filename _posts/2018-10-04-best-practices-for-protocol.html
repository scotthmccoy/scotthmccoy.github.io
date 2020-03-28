---
layout: post
title: Best Practices for @protocol
date: '2018-10-04T17:04:00.000-07:00'
author: Scott McCoy
tags: 
modified_time: '2018-12-28T12:42:43.018-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-1572303627870016582
blogger_orig_url: https://scotthmccoy.blogspot.com/2018/10/best-practices-for-protocol.html
---

Obj-C has a quirky rule: <b>You can't forward declare a superclass or a protocol it conforms to.</b> This rule usually isn't an issue until it ends up being a requirement to do something like put a protocol in its own file such that it can be imported in multiple places, but doing so suddenly prompts an unwinding of circular-import spaghetti where classes that have been importing each other to get access to the things that those classes imported need to be tidied up.&nbsp;<div><br /></div><div>As such, it's generally a good idea to follow the following rules which cost a little bit of effort up front but can save a lot of time doing this sort of cleanup all at once down the line:&nbsp;<div><ol><li>In classes's header files, only import the superclass’s .h and @Class everything else.</li><li>Protocols go in their own .h file. Don't ever forward-declare protocols, just import the .h file.</li><li>As long as you're following rule <a href="https://github.corp.openx.com/mobile/ios-sdk/pull/1">#1</a>, rule <a href="https://github.corp.openx.com/mobile/ios-sdk/pull/2">#2</a> is not as important.</li></ol></div></div>