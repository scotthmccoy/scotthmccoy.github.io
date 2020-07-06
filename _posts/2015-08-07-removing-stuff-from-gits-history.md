---
layout: post
title: Removing stuff from git's history
date: '2015-08-07T15:48:00.002-07:00'
author: Scott McCoy
tags:
- Git
modified_time: '2015-10-28T14:17:44.593-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-1269675778162611965
blogger_orig_url: https://scotthmccoy.blogspot.com/2015/08/removing-stuff-from-gits-history.html
---

<br />Add it to .gitignore in the project root, then...<br /><b>git rm --cached <file>&nbsp;</file></b><br /><br />Also,<br /><br /><div class="p1"><span class="s1"><b>git ls-tree -r master --name-only</b></span></div><div class="p1"><span class="s1"><br /></span></div><div class="p1"><span class="s1">Will show you files that are merged with master in the tree. You can use this plus some clever pipe-grepping to find and <b>git rm --cached</b>&nbsp;the files you wish to forget about. This is very useful for getting rid of .DS_Stores, xcuserdata and the like.</span></div>