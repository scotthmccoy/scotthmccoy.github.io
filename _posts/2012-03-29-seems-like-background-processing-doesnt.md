---
layout: post
title: Background Processing
date: '2012-03-29T16:40:00.003-07:00'
author: Scott McCoy
tags: 
modified_time: '2012-03-29T16:51:12.092-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-2044165356200303404
blogger_orig_url: https://scotthmccoy.blogspot.com/2012/03/seems-like-background-processing-doesnt.html
---

Seems like background processing doesn't start until 5 minutes after your app has closed<br /><br />    backgroundTask = <br />    [application beginBackgroundTaskWithExpirationHandler: <br />    ^{<br />        HLLogInfo(@"beginBackgroundTaskWithExpirationHandler");<br />        dispatch_async(dispatch_get_main_queue(), <br />        ^{<br />            while ([application backgroundTimeRemaining] > 1.0) <br />            {<br />                 HLLogInfo(@"backgroundTimeRemaining = [%f]", [application backgroundTimeRemaining]);<br />            }<br />            <br />            [application endBackgroundTask:backgroundTask];<br />            backgroundTask = UIBackgroundTaskInvalid;<br />        });<br />    }];