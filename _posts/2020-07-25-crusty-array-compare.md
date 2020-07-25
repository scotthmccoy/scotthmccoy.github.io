---
layout: post
title: Crusty Array Compare
date: 2020-07-25 14:52 -0700
---

This is an explanation for the nifty array compare implementation In the famous Crusty video at [38m and 38s](https://www.youtube.com/watch?v=xE5EcHuz52I#t=38m38s).

```
import Foundation
import XCTest

class ArrayCompareTest : XCTestCase {
    
    func arrayCompare<T:Comparable>(lhs:[T], rhs:[T]) -> Bool {
        //This is an incredibly elegant if nearly inscrutable implementation of array match.
        
        //Use `zip` to merge the arrays into an array of tuples, then use `contains` *without an Element arg* to walk each element of the
        //zipped array and bail on the first non-match.
        return lhs.count == rhs.count && !zip(lhs, rhs).contains {
            return $0 != $1
        }
    }
    
    func test() {
        XCTAssertTrue(arrayCompare(lhs:[1,2,3], rhs:[1,2,3]))
        XCTAssertFalse(arrayCompare(lhs:[1,2], rhs:[1,2,3]))
        XCTAssertFalse(arrayCompare(lhs:[1,2,3], rhs:[4,5,6]))
    }
}
```
