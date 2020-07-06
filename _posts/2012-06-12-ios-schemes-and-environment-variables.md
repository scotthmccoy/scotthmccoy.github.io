---
layout: post
title: iOS - Schemes and Environment Variables
date: '2012-06-12T16:30:00.000-07:00'
author: Scott McCoy
tags: 
modified_time: '2012-06-12T16:30:00.120-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-5805851873811933342
blogger_orig_url: https://scotthmccoy.blogspot.com/2012/06/ios-schemes-and-environment-variables.html
---

You can set up environment variables in Schemes and then access them like this:  <pre><br />    //Don't refresh local notifications if we are in TEST mode.<br />    NSString* target = [[[NSProcessInfo processInfo] environment] objectForKey:@"HL_ACTION"];      <br />    <br />    if (![target isEqualToString:@"TEST"])<br />    {<br />        HLLogInfo(@"Logged in!");<br />        [[HLLocalNotificationService instance] refreshUpcomingEventsLocalNotifications];            <br />    }   <br /></pre>