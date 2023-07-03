
Obj-C has a quirky rule: **You can't forward declare a superclass or a protocol it conforms to.** This rule usually isn't an issue until it ends up being a requirement to do something like put a protocol in its own file such that it can be imported in multiple places, but doing so suddenly prompts an unwinding of circular-import spaghetti where classes that have been importing each other to get access to the things that those classes imported need to be tidied up.

As such, it's generally a good idea to follow the following rules which cost a little bit of effort up front but can save a lot of time doing this sort of cleanup all at once down the line:

1. In classes's header files, only import the superclass’s .h and @Class everything else.

2. Protocols go in their own .h file. Don't ever forward-declare protocols, just import the .h file.

As long as you're following rule #1, rule #2 is not as important.
