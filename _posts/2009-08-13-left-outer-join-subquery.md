---
layout: post
title: Left Outer Join Subquery
date: '2009-08-13T17:13:00.001-07:00'
author: Scott McCoy
tags: 
modified_time: '2011-09-14T16:58:57.267-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-3575611266540772615
blogger_orig_url: https://scotthmccoy.blogspot.com/2009/08/left-outer-join-subquery.html
---

I probably already &quot;knew&quot; this from all the SQL I did on ATM, but you can put a subquery into a join statement and pretend it's a table. This heinous little query needed a count(*) added to it, but since we're already doing to group_concat it was concatting the server name like five times (one for every time the item had been downloaded, since it was at the time joining directly on the delivery pickup table).<br /><br /><pre><br />SELECT<br />d.delivery_id,  d.name AS delivery_name,  d.expires_at,<br />GROUP_CONCAT(CASE WHEN t.task_status_id = -2 THEN CONCAT(\'&lt;div class=&quot;complete&quot;&gt;\',REPLACE(s.name, \',\', \'&amp;#44;\'),\'&lt;/div&gt;\') ELSE CONCAT(\'&lt;div class=&quot;pending&quot;&gt;\',REPLACE(s.name, \',\', \'&amp;#44;\'),\'&lt;/div&gt;\') END) AS servers,<br />CASE WHEN d.expires_at &lt;= NOW() THEN &quot;1&quot; ELSE &quot;0&quot; END AS expired,<br />dp_query.times_downloaded<br />FROM delivery d<br />INNER JOIN task t ON d.delivery_id = t.delivery_id<br />INNER JOIN server s ON t.to_server_id = s.server_id<br />left outer join<br />(<br />        select<br />        delivery_id,<br />        count(*) as times_downloaded<br />        from delivery_pickup dp<br />        group by delivery_id<br />) as dp_query on dp_query.delivery_id = d.delivery_id<br /><br />WHERE<br />d.user_id = &quot;'. $_SESSION['LOGGED_IN_USER']['guid'] .'&quot; AND<br />d.created_at BETWEEN &quot;'. $yr .'-'. $mo .'-01 00:00:00&quot; AND &quot;'. $yr .'-'. $mo .'-'. $ld .' 23:59:59&quot;<br />GROUP BY<br />t.delivery_id<br /></pre><br /><br /><br />(That is Diana Martinez' code for FileHero)