---
layout: post
title: Singleton Explicit Setup
date: 2020-09-21 00:37 -0700
---

If possible, accessing a singleton for the first time shouldn't automatically trigger its setup routine. This allows the singleton to be much more easily partially-mocked.
