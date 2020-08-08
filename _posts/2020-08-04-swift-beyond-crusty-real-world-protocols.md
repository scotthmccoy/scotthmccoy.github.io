---
layout: post
title: 🐦 Swift - Beyond Crusty - Real World Protocols
date: 2020-08-04 22:56 -0700
---

Notes from [this video](https://www.youtube.com/watch?v=QCxkaTj7QJs&feature=youtu.be):

* He asserts that POP is composition over inheritance since you're not worrying about a class hierarchy
* You can use protocols in a way that ends up duplicating the evils of inheritance!
* Parameterize your generics on the data type being handled, not on the handler type (This is the same principle used in the Type Erasure Pattern)
* Instead of using a protocol to enforce that an implementer must have some functions, you can enforce that they have some *closures*, then you can just *assign* them!
* Going further, you can have a configuration object be the implementer of this protocol (Configuration design pattern) or even just have it be a struct and not have a protocol. His note on this was "Encapsulate what varies"; which in this scenario I think means "consider what you want to be able to change *without* redesign".
