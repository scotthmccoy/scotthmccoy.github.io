---
layout: post
title: Sharing an intentionally shitty Network (for testing)
date: '2012-07-19T15:30:00.005-07:00'
author: Scott McCoy
tags: 
modified_time: '2012-07-20T10:41:06.884-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-6298036570077020892
blogger_orig_url: https://scotthmccoy.blogspot.com/2012/07/sharing-intentionally-shitty-network.html
---

http://joemiller.me/2010/08/31/simulate-network-latency-packet-loss-and-bandwidth-on-mac-osx/   <pre><br /><br /># Create 2 pipes and assigned traffic to and from our webserver to each:<br />$ sudo  ipfw add pipe 1 ip from any to 10.0.0.1<br />$ sudo  ipfw add pipe 2 ip from 10.0.0.1 to any<br /> <br /># Configure the pipes we just created:<br />$ sudo  ipfw pipe 1 config delay 250ms bw 1Mbit/s plr 0.1<br />$ sudo  ipfw pipe 2 config delay 250ms bw 1Mbit/s plr 0.1<br /><br /><br /><br /><br /><br />$ ping 10.0.0.1<br />PING 10.0.0.1 (10.0.0.1): 56 data bytes<br />64 bytes from 10.0.0.1: icmp_seq=0 ttl=63 time=515.939 ms<br />64 bytes from 10.0.0.1: icmp_seq=1 ttl=63 time=519.864 ms<br />64 bytes from 10.0.0.1: icmp_seq=2 ttl=63 time=521.785 ms<br />Request timeout for icmp_seq 3<br />64 bytes from 10.0.0.1: icmp_seq=4 ttl=63 time=524.461 ms<br /><br /><br /><br /><br /><br />$sudo  ipfw list |grep pipe<br />  01900 pipe 1 ip from any to 10.13.1.133 out<br />  02000 pipe 2 ip from 10.13.1.133 to any in<br />$ sudo  ipfw delete 01900<br />$ sudo  ipfw delete 02000<br /> <br /># or, flush all ipfw rules, not just our pipes<br />$ sudo ipfw -q flush<br /><br /></pre>