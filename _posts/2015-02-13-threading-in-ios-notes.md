---
layout: post
title: Various Threading Tools in iOS
date: '2015-02-13T19:24:00.000-08:00'
author: Scott McCoy
tags: 
modified_time: '2015-02-13T19:24:49.552-08:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-817701791019310262
blogger_orig_url: https://scotthmccoy.blogspot.com/2015/02/threading-in-ios-notes.html
---

You want to use the highest level of abstraction that makes sense:

* NSOperation NSOperationQueue. Wraps GCD.
* performSelectorInBackground
* NSLock
* @synchronized
* atomic properties, which are like an @synchronized(self) block around the property. They're great for isolated values but useless when values depend on each other, like currencyAmount and currencyType. 
* dispatch_sync which submits your block to a queue and waits until the block finishes
* dispatch_async, which submits your block and doesn't wait.
* dispatch_semaphore. if 0 then it's good for synchronization of tasks, if greater than 0 it's good for managing a finite pool of stuff.
* dispatch_queue_create - lets you create your own serialized or concurrent queue.
* dispatch_barrier_async - like having an NSOperationQueue do a waitUntilDone
* dispatch_async can use dispatch_get_main_queue() dispatch_get_global_queue() which has four flavors:
1. DISPATCH_QUEUE_PRIORITY_MAIN (The main thread) 
2. DISPATCH_QUEUE_PRIORITY_HIGH
3. DISPATCH_QUEUE_PRIORITY_DEFAULT
4. DISPATCH_QUEUE_PRIORITY_LOW
