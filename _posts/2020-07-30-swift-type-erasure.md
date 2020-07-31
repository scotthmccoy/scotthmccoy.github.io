---
layout: post
title: 🐦 Swift - Type Erasure
date: 2020-07-30 17:16 -0700
---

## The Problem
One of the things left incomplete in Swift is the ability for the compiler to be able to use a PAT as a first-class type:

```
protocol Cup {
    associatedtype Contents
}

func foo(cup:Cup) { //🛑 Protocol 'Cup' can only be used as a generic constraint because it has Self or associated type requirements
    
}

let arr = [Cup<Tea>]() //🛑 Cannot specialize non-generic type 'Cup'
```

## The Solution

Lets define a few terms before getting started:

* Associated Type: The name protocol's associatedtype. In the above example, this would be "Contents"
* Specialization: The implementing type of the PAT, or the creation of said type.
* Concrete Type: The type associated to the specialization, say, Coffee.

1. The Type Erasure Pattern. This allows substitution of a PAT for a generic AnyPat class. This makes use of a neat swift trick: You can subclass a generic container to a generic container-container and then use a reference of the superclass to refer to an instance of the subclass. This lets you refer to an implementing type *via its concrete type*. It requires a fair bit of boilerplate code to create the Base, Box and Public Wrapper classes (The AnyPat class) and all the trampolines to bounce interactions back to the instance of the specialization retained inside the Box class. 

2. Operationalization - The specialization "operationalizes" itself (ideally through a function on a protocol extension on the PAT) into a non-generic type-erased object by creating or consuming closures that wrap interactions with the specialization. This allows a homogenous array of operations that might each operate on different specializations which effectively achieves a heterogeneous array of the PAT. It also free consumers to be focused solely on their own responsibilities (consuming operations) instead of performing type erasure or dealing with generics.


