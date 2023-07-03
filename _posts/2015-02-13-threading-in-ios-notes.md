
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
