---
layout: post
title: Crusty Comparable Array - Bridge Building Between Static and Dynamic Worlds
date: 2020-07-25 16:09 -0700
---

In the Crusty Video at [41m5s](https://www.youtube.com/watch?v=xE5EcHuz52I#t=41m5s), they show how you can build a bridge between 

`Equatable` has `Self` requirements, so putting it on Drawable puts it into the dynamically dispatched world - but we don't want that, we want Drawable to live in the Statically dispatched world so that that we can make an array of Drawable! So we need our own function that does comparison, without using `Self`.


```
protocol Drawable {
    func draw()
    
    //Adding this here forces you to implement it in your Drawable struct so you can guarantee that an array of Drawables will be comparable even without Equatable.
    //But if you just make your Drawable implementation also implement Equatable, then you get the default implementation of compareDrawable provided by the `Drawble where Self : Equatable` protocol extension!
    //As an added bonus, since Equatable on a struct auto-synthesizes the == function by comparing member properties, the default implementation can just lean on == if the class types match.
    func compareDrawable(other: Drawable) -> Bool
}

extension Drawable where Self : Equatable {
    func compareDrawable(other: Drawable) -> Bool {
        
        //If the class types don't match, bail.
        guard let o = other as? Self else {
            return false
        }
        
        //Lean on the auto-synthesized == provided by Equatable-on-struct
        //(Or if you implement Drawable on class, your own implementation of ==)
        return self == o
    }
}


struct DrawableA : Drawable, Equatable {
    var a:Int
    func draw() {
        print("drawing DrawableAndEquatable")
    }
}

struct DrawableB : Drawable, Equatable {
    var b:Int
    func draw() {
        print("drawing DrawableButNotEquatable")
    }
}

let drawableA1 = DrawableA(a:1)
let drawableA2 = DrawableA(a:2)
let drawableB = DrawableB(b:3)

var isEqual:Bool

//False since 1 != 2
isEqual = drawableA1 == drawableA2

//Tautology
isEqual = drawableB == drawableB




//Can't do this since they are different classes!
//var isEqual = drawableA1 == drawableB

//But we *can* do this using the compareDrawable default definition/implementation:
drawableA1.compareDrawable(other: drawableB)

//So we should standardize to using default definition/implementation of scootyEqualTo to compare Drawables:
drawableA1.compareDrawable(other: drawableA1)
drawableA1.compareDrawable(other: drawableA2)
drawableA1.compareDrawable(other: drawableB)
```