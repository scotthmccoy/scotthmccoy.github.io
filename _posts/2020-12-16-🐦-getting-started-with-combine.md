

Thoughts on Combine

I finished Ray Wenderlich's [Getting Started With Combine](https://www.raywenderlich.com/7864801-combine-getting-started) tutorial, then switched it to use Tumblr's API (which doesn't have the data limits that Unsplash does) and then [refactored it to proper MVC](https://github.com/scotthmccoy/GettingStartedWithCombine).

It's both [functional](https://codeburst.io/a-beginner-friendly-intro-to-functional-programming-4f69aa109569) and [reactive](https://developers.redhat.com/blog/2017/06/30/5-things-to-know-about-reactive-programming/) which in practice mostly means function chaining and subscribing to asynchronous event streams. At first it felt akward replacing delegates, notifications, timers, completion blocks, callbacks and whatnot all with Publishers but I have to admit that it clearly makes for compact and elegant code, especially when dealing with bog-standard chores like creating data structures from a JSON API. 