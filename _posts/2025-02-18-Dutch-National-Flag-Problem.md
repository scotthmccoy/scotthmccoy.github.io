---
title: Dijkstra's Dutch National Flag Algorithm
---

https://en.wikipedia.org/wiki/Dutch_national_flag_problem

This lovely algorithm sorts an array into 3 parts (like the Dutch flag 🇳🇱!), in O(n) time, in-place, while using no additional space beyond a few control variables.

It works by having the top group grow down from the top of the array, the bottom group grow up from the bottom, and keeping the middle group just above the bottom. 

```
var array = [1,1,2,1,3,2,3,2]

dutchSort(arr: &array, mid: 2)

/*
procedure three-way-partition(A : array of values, mid : value):
    i ← 0
    j ← 0
    k ← size of A - 1

    while j <= k:
        if A[j] < mid:
            swap A[i] and A[j]
            i ← i + 1
            j ← j + 1
        else if A[j] > mid:
            swap A[j] and A[k]
            k ← k - 1
        else:
            j ← j + 1
*/

func dutchSort<T:Comparable>(arr: inout [T], mid: T) {
    var i = 0
    var j = 0
    var k = arr.count - 1
    var buffer = mid
    
    while j <= k {
        if arr[j] < mid {
            // Swap arr[i] and arr[j]
            buffer = arr[i]
            arr[i] = arr[j]
            arr[j] = buffer
            
            i += 1
            j += 1
        } else if arr[j] > mid {
            // Swap arr[j] and arr[k]
            buffer = arr[j]
            arr[j] = arr[k]
            arr[k] = buffer
            
            k -= 1
        } else {
            j = j + 1
        }
    }
}
```
