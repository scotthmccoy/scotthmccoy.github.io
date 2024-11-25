

```
import UIKit

extension Array<Int> {

    //Kadane's Algorithm
    // def max_subarray(numbers):
    // """Find the largest sum of any contiguous subarray."""
    // best_sum = float('-inf')
    // current_sum = 0
    // for x in numbers:
    //     current_sum = max(x, current_sum + x)
    //     best_sum = max(best_sum, current_sum)
    // return best_sum
    func maximumSubarray() -> ArraySlice<Int> {

        var bestSum = Int.min
        var currentSum = 0
        
        var startIndex = 0
        var endIndex = 0
        
        var bestStartIndex = 0
        var bestEndIndex = 0
        
        for tuple in self.enumerated() {
            
            let potentialNewSum = currentSum + tuple.element
            
            if tuple.element > potentialNewSum {
                // Start the window over here
                currentSum = tuple.element
                startIndex = tuple.offset
                endIndex = tuple.offset
            } else {
                // Increase the end of the window to include the new element
                currentSum = potentialNewSum
                endIndex = tuple.offset
            }
            
            if currentSum > bestSum {
                bestSum = currentSum
                bestStartIndex = startIndex
                bestEndIndex = endIndex
            }
        }
        return self[bestStartIndex...bestEndIndex]
    }
    
    func maxProfit() -> Int {
        guard count >= 2 else {
            return 0
        }

        var last:Int? = nil
        let changes:[Int] = self.compactMap {
            if last != nil {
                let ret = $0 - last!
                last = $0
                return ret
            } else {
                last = $0
                return nil
            }
        }

        let bestRange = changes.maximumSubarray()
        
        let buyPrice = self[bestRange.startIndex]
        let sellPrice = self[bestRange.endIndex]
        
        let profit = sellPrice - buyPrice

        return Swift.max(0,profit)
    }
}
```
