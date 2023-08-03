
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
