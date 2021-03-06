---
layout: post
title: The && and || operators in unix
date: '2011-09-11T18:49:00.001-07:00'
author: Scott McCoy
tags: 
modified_time: '2011-09-12T00:05:04.666-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-3594158776472448809
blogger_orig_url: https://scotthmccoy.blogspot.com/2011/09/and-operators-in-unix.html
---

<pre>command1 && { command2 ; command3 ; command4 ; }</pre><br /><br />If the exit status of command1 is true (zero), commands 2, 3, and 4 will be performed.<br /><br />For example:<br /><pre>git stash show -p | git apply && git stash drop</pre><br /><br />Runs <span style="font-weight:bold;">git stash show -p</span> and pipes it to <span style="font-weight:bold;">git apply && git stash drop</span>. If <span style="font-weight:bold;">git apply</span> returns 0 on the line, then <span style="font-weight:bold;">git stash drop</span> takes the line.<br /><br />The effect is that only files that are applied without conflict are dropped from the stash.<br /><br />(The git command didn't work, but you get the idea with && and ||)