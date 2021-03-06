---
layout: post
title: 🐦 Swift - What is a Generator?
date: 2020-07-27 15:41 -0700
---

From [this blog post](https://thoughtbot.com/blog/swift-sequences), a `Generator` might be better named as `Enumerator`. I think they went with `Generator` since the formal definition of the word "enumerate" comes with an association with numbers, ordinality, etc:

```
for x in mySequence {
    // iterations here
}
```


Swift actually turns that into:

```
var __g: Generator = mySequence.generate()
while let x = __g.next() {
    // iterations here
}
```

So, breaking this down:

Swift calls generate() on the provided `Sequence`, returning a `Generator`. This object is stored in a private variable, `__g`, which then gets called with next(), which returns a type of Element?. This object is conditionally unwrapped in the while let statement, and assigned to x. It then performs this operation until next() has nothing left to return.

For the record, I’m not crazy about the naming here. I think it’s probably best to think `Enumerator` instead of `Generator`, at least in this use case. I’ve filed a radar to this effect, but have already gotten some feedback that this change might not be so simple.
