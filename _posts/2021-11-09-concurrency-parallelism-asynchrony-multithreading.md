---
title: Concurrency, Parallelism, Asynchrony, and Multithreading
---

- Concurrency is the umbrella term; it means two or more things are in progress at once. 
  
- Asynchrony: This means that your program performs non-blocking operations. For example, it can initiate a request for a remote resource via HTTP and then go on to do some other task while it waits for the response to be received. It’s a bit like when you send an email and then go on with your life without waiting for a response. Think of DispatchQueue.async.

- Multithreading: This is a software implementation allowing different threads to be executed concurrently. A multithreaded program appears to be doing several things at the same time even when it’s running on a single-core machine. This is a bit like chatting with different people through various IM windows; although you’re actually switching back and forth, the net result is that you’re having multiple conversations at the same time.

- Parallelism: This means that your program leverages the hardware of multi-core machines to execute tasks at the same time by breaking up work into tasks, each of which is executed on a separate core. It’s a bit like singing in the shower: you’re actually doing two things at *exactly* the same time.



![image](https://github.com/user-attachments/assets/8d0e327b-b25e-404f-8005-5316a606ac1d)


Asynchrony is a separate concept (even though related in some contexts). It refers to the fact that one event might be happening at a different time (not in synchrony) to another event. The below diagrams illustrate what's the difference between a synchronous and an asynchronous execution, where the actors can correspond to different threads, processes or even servers.

![image](https://github.com/user-attachments/assets/ee9f87e4-c9d7-4e59-bf2b-669c07f554ee)

![image](https://github.com/user-attachments/assets/26fb5e3d-9a38-4d44-9127-d027f146cf66)

# Sources
https://stackoverflow.com/questions/4844637/what-is-the-difference-between-concurrency-parallelism-and-asynchronous-methods



[This Article](https://learningswift.brightdigit.com/asynchronous-multi-threaded-parallel-world-of-swift/) discusses the distinction and some ways to deal with making a DispatchQueue concurrent/parallel.

