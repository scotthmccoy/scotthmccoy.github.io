From [It's probably time to stop recommending Clean Code](https://qntm.org/clean):
> Clean Code mixes together a disarming combination of strong, timeless advice and advice which is highly questionable or dated or both.

Clean Code was first published by [Robert Martin](https://scotthmccoy.github.io/2023/12/27/uncle-bob-considered-harmful.html) in 2008 and like him, it's aging poorly.

* The book is useless to newbies who would require handholding by a seasoned professional to point out what of the advice is situational, dogmatic, impractical, outdated, or contradictory.
* It's of questionable value to a seasoned professional who might hope to sharpen fundamentals but might gain some intellectual contagion instead, like "code comments are bad".
* Martin often omits discussion of potential drawbacks to taking his advice and is prone to hyperbole. 
* The code samples are absolutely _awful_, frequently breaking many of his established rules, particularly "No Side Effects". This made the book incredibly confusing for me to read in 2012.


Nuggets of wisdom and some missing caveats:
* Function names should be descriptive, consistent, be verb phrases, and should be chosen carefully
* Functions should generally either be commands, which do something, or queries, which answer something, but not both.
* Functions should not have side effects
* Functions should do exactly one thing, and do it well, **provided that we aren't too dogmatic about how we define "one thing", and we understand that in plenty of cases this can be highly impractical**.
* It should be possible to read a single source file from top to bottom as narrative, with the level of abstraction in each function descending as we read on, each function calling out to others further down.
* He asserts that code duplication "may be the root of all evil in software" and fiercely advocates DRY, but we now understand that **duplication is cheaper than the wrong abstraction**.
* He asserts that an ideal function is two to four lines of code long. This means many/most functions will only called from one location. My own experience has taught me this is a bad code smell; that **a function called from only one location is likely a dependency that should be injected** and that **it is possible impose so much abstraction and structure that maintainability of code is _reduced_, not improved**.
* He enthusiastically supports TDD, but fails to talk about the _cost_ of TDD - that figuring out how to break down the programming task in front of you so that you _can_ write a failing test is often expensive and pointless.

QNTM proposes [A Philosophy of Software Design (2018)](https://www.amazon.com/Philosophy-Software-Design-John-Ousterhout/dp/1732102201) as partial replacement for Clean Code.
