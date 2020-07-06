---
layout: post
title: Codable and Inheritance
date: '2017-12-12T17:44:00.003-08:00'
author: Scott McCoy
tags: 
modified_time: '2017-12-12T17:46:59.886-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-4458764888695496647
blogger_orig_url: https://scotthmccoy.blogspot.com/2017/12/codable-and-inheritance.html
---

Codable is basically the holy grail of JSON parsing but it's got some annoying constraints. Basically, you can't get the synthesized funcs if you inherit Codable from a superclass - it's not safe for the compiler to assume *what* you want to override, so it just decides to decode the superclass's vars:<br /><br />From https://bugs.swift.org/browse/SR-5125,<br /><i>There is simply no way to know what type of container the parent class will ask for (e.g. Store is allowed to request a keyed encoder/decoder, but BaseStore can ask for an unkeyed encoder/decoder — those can't be shared!), so it's not safe for the compiler to do anything but use those encapsulating encoders.<br /></i>This means you gotta implement Codable on every class you want those synthesizers on and just deal with the inelegance of things like not being able to decode an array of an abstract superclass of your object.<br /><br /><br />