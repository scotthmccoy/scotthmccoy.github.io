---
layout: post
title: JIRA Tricks Learned at OpenX
date: '2018-07-12T18:37:00.001-07:00'
author: Scott McCoy
tags: 
modified_time: '2018-07-14T11:17:43.656-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-1044637073152067098
blogger_orig_url: https://scotthmccoy.blogspot.com/2018/07/jira-tricks-learned-at-openx-unfinished.html
---

Used ScriptRunner to gather data<br /><br />I made Boards for all team members that filtered the project to just that person and used that to track overcommitment &amp; velocity over time. I put the boards on a dashboard and the added visibility really helped curb overcommitment. I was able to copy individual velocity data into a spreadsheet to help our more optimistic individuals calculate what their commitment for the next sprint aught to be:<br /><br />https://docs.google.com/spreadsheets/d/1b2-j2-5ooNB9SsldQt_c27uA3V1NegM2dCwhNHX3Qq4/<br /><br />At one point the question was raised as to how much OOO and Vacation days were impacting the accuracy of the data. I moved from tracking it per sprint and using "drop the highest and the lowest velocity" technique to smooth the results out to tracking Velocity Per Person Per Day. Surprisingly the gain from moving to this more precise measurement was very slight - something like 10%.<br /><br />Later on I learned to use the scriptRunner to get the data out without needing to use Boards and Filters to do it:<br /><br />Velocity Last Sprint:<br /><span style="font-family: &quot;courier new&quot; , &quot;courier&quot; , monospace;">project = mobile AND status in (Resolved, "QA Verified", Closed) AND assignee = scott.mccoy AND issueFunction in previousSprint(Mobile) AND issueFunction in aggregateExpression("Total Story Points Last Sprint", "storyPoints.sum()")</span>