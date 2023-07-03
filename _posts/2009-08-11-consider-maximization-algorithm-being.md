Consider an adventurer looting a treasure chest. There are more items in the chest than they can carry and they wish to maximize the amount of cash value they take with them.

Consider a maximization the algorithm being applied to the following set of items, with a strength of 5 units of weight carrying capacity:

| Item ID | Weight | Value | Title                        |
| ------- | ------ | ----- | ---------------------------- |
| 0       | 0      | 0     | Worthless Placeholder Object |
| 1       | 2      | 3     | Jug Of Mead                  |
| 2       | 3      | 4     | Keg of Spices                |
| 3       | 4      | 5     | Haunch of Mutton             |
| 4       | 5      | 6     | Iron Longsword               |



The placeholder object might seems odd but it's important to have it as a starting point. This is due to an interesting quirk of optimization - every potential optimal solution contains a previous optimal solution

By inspection, If we have a strength of 5, the optimal solution is to take the Mead and Spices for a total haul of 7 gp.

Now of course the *truly* optimal solution is to feast on Mead and Mutton and then return to the town drunk
and armed with the Iron Longsword, but lets assume that you are a very frugally-minded adventurer and wish to simply maximize
your cashflow.

To prove that Mead+Spices is the optimal solution, we create a table. (The term "programming" actually refers to a tabular
method and it predates computer programming.) We fill up this table one spot at a time starting with the top left, so that
it consists of is the optimal cash value after having considered a given item for a given level of strength. Here's what
the table will ultimately look like:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |
| 2       | 0 | 0 | 3 | 4 | 4 | 7 |
| 3       | 0 | 0 | 3 | 4 | 5 | 7 |
| 4       | 0 | 0 | 3 | 4 | 5 | 7 |



The first thing we do is consider item #0, the Worthless Placeholder Object. It is weightless and
has a cash value of zero, so for every possible level of strength, we loot the item and write down that
the optimal value at this point is zero gold. This might seem odd but it's really there just to get
things started with a line of "optimal solutions" equal to zero, since for future items our decisions
must always reference a *previous* optimal solution.

Our table now looks like this:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |

(For the sake of brevity I'll abbreviate the words "optimal solution" to "OS" from now on.)

Next we move on to item #1, the Jug of Mead, which weighs 2 pounds and is worth 3 gold. With a strength of
0 we can't carry it, so we must write down our OS from the previous line when we had the same strength: zero gold.

We do the same with strength 1, writing down the previous line's OS for strength 1: zero gold. Our table now looks like this:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 |   |   |   |   |

At strength 2, we can carry the Jug of Mead and have two options:
Option 1) We can either again go with the OS from the previous line for this strength level (zero gold)
OR
Option 2) Add the Jug of Mead to an OS from the previous line with our strength reduced by the 2 pound weight of the Jug, to reflect
that we must be able to carry everything in the previous OS. Since we are at item_id=1 and tmp_str=2, the OS we look back
to is item_id=0 and tmp_str=0. We add the value of the Jug to this previous OS and get 3 gold.

Option 2 is obviously better, so we go with that for strength 2. We essentially do the same for strength 3, strength 4 and strength 5
as well, with the only difference being that we are looking back to (item_id=0,tmp_str=1) for strength 3, (item_id=0,tmp_str=2) for strength 4,
and (item_id=0,tmp_str=3) for strength 5.

Our table now looks like this:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |     

Next we move on to item #2, the Keg of Spices, which weighs 3 pounds and is worth 4 gold. For strength 0,1 and 2,
we can't carry it, so we write down what we wrote down the last time we had that level of strength, which
is 0,0,3. Our table now looks like this:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |
| 2       | 0 | 0 | 3 | 0 | 0 | 0 |

At strength 3, we can carry the Keg and have two options:
Option 1) We can either again go with the OS from the previous line for this strength level: 3g.
OR
Option 2) Add the Keg of Spices to an OS from the previous line with our strength reduced by the 3 pound weight of the Keg, to reflect
that we must be able to carry everything in the previous OS. Since we are at item_id=2 and tmp_str=3, the OS we look back
to is item_id=1 and tmp_str=0, which is 0 gold. We add the value of the Keg to this previous OS and get 4g, making option 2 better than
option 1.

Our table now looks like this:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |
| 2       | 0 | 0 | 3 | 4 |   |   |

At strength 4 we essentially repeat the decision we made at strength 3, with the only difference being that our strength is now one
pound higher, so our lookback item is one strength higher as well. We look back to (item_id=1,tmp_str=1) instead of (item_id=1,tmp_str=0),
making our table look like this:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |
| 2       | 0 | 0 | 3 | 4 | 4 |   |


At strength 5, we can carry the Keg and have two options:
Option 1) We can either again go with the OS from the previous line for this strength level (3 gold)
OR
Option 2) Add the Keg of Spices to an OS from the previous line with our strength reduced by the 3 pound weight of the Keg, to reflect
that we must be able to carry everything in the previous OS. Since we are at (item_id=2,tmp_str=5), the OS we look back
to is (item_id=1,tmp_str=2), which is 3 gold. We add the value of the Keg (4gp) to this previous OS and get 7 gold, making option 2
better than option 1.

Our table now looks like this:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |
| 2       | 0 | 0 | 3 | 4 | 4 | 7 |

                     
On to item 3, the Haunch of Mutton, which weighs 4 pounds and is worth five gold. For strength 0,1,2 and 3, we cannot carry it
and must go with the previous OS for that strength level, making our table look like this:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |
| 2       | 0 | 0 | 3 | 4 | 7 | 7 |
| 3       | 0 | 0 | 3 | 4 |   |   |
      
At strength 4, we can carry the Mutton and have two options:
1) We can either again go with the OS from the previous line for this strength level (4 gold)
OR
2) Add the Haunch of Mutton to an OS from the previous line with our strength reduced by the 4 pound weight of the Haunch, to reflect
that we must be able to carry everything in the previous OS. Since we are at item_id=3 and tmp_str=4, the OS we look back
to is (item_id=2,tmp_str=0), which is 0 gold. We add the value of the Haunch (5gp) to this previous OS and get 5 gold, making option 2
better than option 1.

Our table now looks like this:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |
| 2       | 0 | 0 | 3 | 4 | 7 | 7 |
| 3       | 0 | 0 | 3 | 4 | 5 |   |
       
At strength 5, we can carry the Mutton and have two options:
1) We can either again go with the OS from the previous line for this strength level (7 gold)
OR
2) Add the Haunch of Mutton to an OS from the previous line with our strength reduced by the 4lb weight of the Haunch, to reflect
that we must be able to carry everything in the previous OS. Since we are at (item_id=3,tmp_str=4), the OS we look back
to is (item_id=2,tmp_str=0), which is 0 gold. We add the value of the Haunch (5 gold) to this previous OS and get 5 gold, making
option 1 better than option 2.

Our table now looks like this:

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |
| 2       | 0 | 0 | 3 | 4 | 7 | 7 |
| 3       | 0 | 0 | 3 | 4 | 5 | 7 |


On to item 4, the Iron Longsword, which weighs 5 pounds and is worth 6 gold. For strength 0,1,2,3 and 4, we cannot carry it
and must go with the previous OS for that strength level, making our table look like this:


| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |
| 2       | 0 | 0 | 3 | 4 | 7 | 7 |
| 3       | 0 | 0 | 3 | 4 | 5 | 7 |
| 4       | 0 | 0 | 3 | 4 | 5 |   |

At strength 6, we can carry the Longword and have two options:
1) We can either again go with the OS from the previous line for this strength level (7 gold)
OR
2) Add the Iron Longsword to an OS from the previous line with our strength reduced by the 5 pound weight of the Longsword, to reflect
that we must be able to carry everything in the previous OS. Since we are at (item_id=4,tmp_str=5), the OS we look back
to is (item_id=3,tmp_str=0), which is 0 gold. We add the value of the Longsword (6 gold) to this previous OS and get 6 gold, making
option 1 better than option 2.

Our table now looks like this, and we are done!

| Item ID | 0 | 1 | 2 | 3 | 4 | 5 |
| ------- | - | - | - | - | - | - |
| 0       | 0 | 0 | 0 | 0 | 0 | 0 |
| 1       | 0 | 0 | 3 | 3 | 3 | 3 |
| 2       | 0 | 0 | 3 | 4 | 7 | 7 |
| 3       | 0 | 0 | 3 | 4 | 5 | 7 |
| 4       | 0 | 0 | 3 | 4 | 5 | 7 |


Program Output:

Items Left Behind:
Name                                     Weight     Value     
Jug of Mead                              2          3         
Iron Longsword                           5          6         
=================================================================
                                         7          9
Items Taken:
Name                                     Weight     Value     
Keg of Spices                            3          4         
Haunch of Mutton                         4          5         
=================================================================
                                         7          9
Unused Capacity: 0

