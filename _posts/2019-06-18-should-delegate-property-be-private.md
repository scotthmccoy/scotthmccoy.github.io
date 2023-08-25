
Should a delegate property be public or private?

TLDR: They should be public.

Typically you see the following:
```
self.obj = [[MyClasss alloc] init];
obj.delegate = self;
[obj startDoingThingsThatCouldResultInDelegateMessages];
```

And want to refactor it into this:
```
self.obj = [[MyClass alloc] initWithDelegate:self];
```

But, post-refactor, the object can be sending messages before assignment to self.obj is complete, or even before initialization is complete!

If you don't *care* about this, chances are MyClass's duties are stateless, synchronous, or both. If this is true, it means you probably don't need to retain obj or even use the delegate pattern, since Delegate is typically used when an object maintains an internal state and messaging with the delegate over a long life cycle. You may be better served by refactoring to a class method with the Handler pattern:

```
MyClass.doStuffWithSuccessHandler() { result in
  ...
}
```

Lastly, delegates are generally weak, which means making one private (which you typically do so that the property is free from outside influence) is pointless since it can still become nil at any time.
