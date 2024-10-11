This [Github Blog](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0414-region-based-isolation.md) defines them as:

# Isolation Domains
> Swift Concurrency assigns values to *isolation domains* determined by actor and
task boundaries. Code running in distinct isolation domains can execute
concurrently, and `Sendable` checking defines away concurrent access to
shared mutable state by preventing non-`Sendable` values from being passed
across isolation boundaries full stop. In practice, this is a significant
semantic restriction, because it forbids natural programming patterns that are
free of data races.

So basically, we instead of saying this code is isolated to this _actor_, we should say it's isolated to this _domain_ because it could include a Task.

# Isolation Regions
> `[(a)]`: A single disconnected region with a single value.
> 
> `[{(a), actorInstance}]`: A single region that is isolated to actorInstance.
> 
> `[(a), {(b), actorInstance}]`: Two values in separate isolation regions. a's region is disconnected but b's region is assigned to the isolation domain of the actor instance actorInstance.
> 
> `[{(x, y), @OtherActor}, (z), (w, t)]`: Five values in three separate isolation regions. x and y are within one isolation region that is isolated to the global actor @OtherActor. z is within its own disconnected isolation region. w and t are within the same disconnected region.
> 
> `[{(a), Task1}]`: A single region that is part of Task1's isolation domain.
