---
layout: post
title: Affine Wealth Model
date: 2020-08-07 16:56 -0700
---

## Thoughts on the AWM as an Economic Model
Sadly, AWM's notability isn't in its predictive power or the elegance of its mathematical model\*. What's notable about AWM is that it makes some very interesting *observations*:

1. There can exist a seemingly paradoxical game that has a positive expected value on each play but a negative one over time.
2. It's both telling and worrying that that you *can* model a modern nation's wealth divide to within 2% of accuracy using agents interacting completely at random using only the chi variable (the potency of redistributive efforts) and that the only thing preventing an eventual slide into total oligarchy are those redistributive efforts.

*In fact some folks on Reddit who sound like they really know what they're talking about complain that all it really accomplishes is creating Lorenz curves in 3 variables when it usually only takes 2, and they say that this smells like either an overfit or a "geocentric model"; that it works, but takes more effort than is neccessary. 

## Thoughts on the Code

1. I'm concerned that the way the zeta factor biases the coin can cause a person with enough wealth to have a 100% win rate.
2. The protocol extensions to acheive a sum and average func are pretty rad.
3. The gini coefficient is VERY appealing as a simple mathematical measure of wealth inequality. At O(n^2) it's a bit inefficient, and I'd probably want to do a (1-gini)*100 to get a "equality percentage"."

Code:
```
//https://www.scientificamerican.com/article/is-inequality-inevitable/
//https://arxiv.org/pdf/1604.02370.pdf
//https://github.com/Adriandl/Econ_MC/blob/master/c/AWM.cpp

import Foundation

extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : Element(sum()) / Element(count) }
}


func chiFactor(currentWealth:Double, meanWealth:Double, chi:Double) -> Double {
    let distanceToMeanWealth = meanWealth - currentWealth
    let ret = chi * distanceToMeanWealth
    return ret
}




//Flips a coin that is biased in favor of the wealthier person.
//If one partner is rich enough and zeta is high enough, victory can be impossible for the poorer partner.
//"true" means victory for the poorer partner, "false" means victory for the richer partner
func coinfFlip(wealthPoorer:Double, wealthRicher:Double, meanWealth:Double, zeta:Double) -> Bool {
    
    //Treat a "heads" as being 1, and a "tails" as being -1.
    //A coin with an expected value of 4 would have 5 heads for every 1 tails
    let expectedValue = zeta * (wealthRicher - wealthPoorer)/meanWealth
    let threshold = 0.5 * (1 + expectedValue)
    let randomValue = Double.random(in: 0...1)
    let ret = randomValue < threshold
    return ret
}

//A measure of inequality of wealth, where 0 means "everyone has equal wealth" and 1 means "a single person has all of the money.
//Countries by GC in
func giniCoefficient(arr:[Double]) -> Double {
    let sorted = arr.sorted()
    var total:Double = 0
    for i in sorted {
        for j in sorted {
            total += abs(i-j)
        }
    }
    
    let ret = total / (2 * pow(Double(sorted.count),2) * sorted.average())
    return ret
}

var numAgents = 100
var initialWealth = 100.0
var numTurns = 1000

//Simulation params
let deltaWForVictory = 0.2
let deltaWForDefeat = 0.17

//Chi Represents wealth taxes for those above mean wealth and subsidies for those below.
//Zeta is a level of bias for the coin flip in favor of the wealthier party proportional to their wealth above the mean.
//
let chi = 0.036
let zeta = 0.050
let kappa = 0.058

var agents = Array(repeating: initialWealth, count:numAgents)



for _ in 1...numTurns {
    //Pick two agents at random
    let agentIndicies = [Int.random(in: 0..<numAgents), Int.random(in: 0..<numAgents)].sorted {
        agents[$0] < agents[$1]
    }
    
    //Determine who is richer and who is poorer
    let indexPoorer = agentIndicies[0]
    let indexRicher = agentIndicies[1]
    
    
    //Flip the coin, biasing in favor of the richer
    if coinfFlip(wealthPoorer:agents[indexPoorer], wealthRicher:agents[indexRicher], meanWealth:initialWealth, zeta:zeta) {
        //Victory for poorer
        //Poorer gains deltaWForVictory of their current wealth from the richer
        let amountTransferred = agents[indexPoorer] * deltaWForVictory
        agents[indexPoorer] += amountTransferred
        agents[indexRicher] -= amountTransferred
    } else {
        //Defeat for poorer
        //Poorer looses deltaWForDefeat of their current wealth to the richer
        let amountTransferred = agents[indexPoorer] * deltaWForDefeat
        agents[indexPoorer] -= amountTransferred
        agents[indexRicher] += amountTransferred
    }
    
    //Step each agent toward the mean
    for i in 0..<numAgents {
        agents[i] += chiFactor(currentWealth:agents[i], meanWealth:initialWealth, chi:chi)/Double(numTurns)
    }
}

agents.sort()
print(agents)
print("Average: \(agents.average())")
print("Gini Coefficient: \(giniCoefficient(arr:agents))")
```






