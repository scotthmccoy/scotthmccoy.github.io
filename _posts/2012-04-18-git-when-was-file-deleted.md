---
layout: post
title: Git - Restore deleted file. Or, when was a file modified?
date: '2012-04-18T15:36:00.006-07:00'
author: Scott McCoy
tags:
- Git
modified_time: '2015-08-07T15:51:22.760-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-1490290333682618567
blogger_orig_url: https://scotthmccoy.blogspot.com/2012/04/git-when-was-file-deleted.html
---

From: http://stackoverflow.com/questions/953481/restore-a-deleted-file-in-a-git-repo<br /><br />Use git rev-list! This shows you the <span style="font-weight:bold;">last commit that modified a particular path</span>:<br /><span style="font-weight:bold;">git rev-list -n 1 HEAD -- ./Source/iPhone/Sharing/HLTwitterLoginViewController.xib<br /></span><br /><br />(It really shows all commits that affected a particular path, but Limit the number of commits to output to 1.)<br /><br />Example:<br />cslam0542:halo-ios scotthmccoy$ <span style="font-weight:bold;">git rev-list -n 1 HEAD -- ./Source/iPhone/Sharing/HLTwitterLoginViewController.xib</span><br />e72d24c852a473b3eec1862971a3cc51564075c9<br />cslam0542:halo-ios scotthmccoy$ <br /><br />Paste that hash into SourceTree to find more info. Now that we've identified the commit, you can restore the file like so in ONE COMMAND!<br /><br /><span style="font-weight:bold;">git checkout (HASH)^ -- (PATH)</span><br /><br />For example:<br /><span style="font-weight:bold;">git checkout e72d24c852a473b3eec1862971a3cc51564075c9^ -- ./Source/iPhone/Sharing/HLTwitterLoginViewController.xib</span><br /><br />That says checkout the commit one before the commit represented by (HASH), but only fetch this one file.