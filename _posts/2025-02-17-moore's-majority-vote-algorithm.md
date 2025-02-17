```
    func majorityElement(_ nums: [Int]) -> Int {
        // https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_majority_vote_algorithm
        var c = 0
        var m: Int? = nil
        nums.forEach {
            if c == 0 {
                c = 1
                m = $0
            } else if m == $0 {
                c+=1
            } else {
                c-=1
            }
        }
        return m!
    }
```
