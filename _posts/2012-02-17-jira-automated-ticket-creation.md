---
layout: post
title: JIRA Automated Ticket Creation
date: '2012-02-17T10:30:00.000-08:00'
author: Scott McCoy
tags: 
modified_time: '2012-02-17T10:36:38.960-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-4311726187200948965
blogger_orig_url: https://scotthmccoy.blogspot.com/2012/02/jira-automated-ticket-creation.html
---

ssh scott@10.0.200.31<br /><br />Usage: perl jira-ticket-create.pl "Convert ./Source/iPad/Checkout/HLiPadCheckoutViewController.xib"<br /><br /><pre><br />#!/usr/bin/perl -w<br />use strict;<br />use Data::Dumper;<br />use JIRA::Client;<br /><br />my $jira = JIRA::Client->new('http://jira.hautelook.net/', 'scott.mccoy', 'password');<br /><br />  my $issue = $jira->create_issue(<br />    {<br />      project => 'IOS',<br />      type => 'Improvement',<br />      summary => $ARGV[0],<br />      assignee => 'ian.broyles',<br />      fixVersions => ['IOS 1.2.2 Mayday']<br />    }<br />  );<br /><br /><br />exit;<br /></pre>