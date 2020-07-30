---
layout: post
title: Obj-C Property Attributes
date: 2020-07-28 15:13 -0700
---


|  Name             |       Meaning                                                                                                              | Default |
|-------------------|----------------------------------------------------------------------------------------------------------------------------|---------|
| atomic	        | Equivalent of @synchronized on the property. Uses a spin_lock under the hood.                                              |   Yes   |
| nonatomic         | Opposite of `atomic`. Faster                                                                                               |   No    |
| strong            | Strong                                                                                                                     |   Yes   |
| retain            | Identical to `strong`.                                                                                                     |   Yes*  |
| weak              | Weak, becomes nil when deallocated                                                                                         |   No    |
| assign            | Weak, still points at old memory location once deallocated. Default for primitive types.                                   |   Yes*  |
| unsafe_unretained | Identical to `assign`                                                                                                      |   No    |
| copy              | Sends a `copy` message to the object and assigns the pointer to the result                                                 |   No    |
| readwrite         |                                                                                                                            |   Yes   |
| readonly          |                                                                                                                            |   No    |
| nullable          |                                                                                                                            |   Yes   |
| nonnull           |                                                                                                                            |   No    |