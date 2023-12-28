Similar to the old heterogeneous array problem, you really shouldn’t ever _want_ to compare 2 of a protocol, and having to ask how to do it is sign that your code might smell worse than you realize:

1. If the concrete types are object types, you’re trying to treat it like a value by comparing it. 
    1. Perhaps the comparison is necessary because multiple objects are using the same scope, like an event handler. In this case you may want to limit the scope by switching to a closure-based design or an async-await-based design instead.
2. If the concrete types are value types, you should really just be comparing those values directly.
    1. If the protocol exists to support the scope handling different value types, the value should probably be either refactored to
      1. An enum, which restricts the possible types of value to a set known at compile time, or
      2. A generic argument conforming to a protocol that describes how to handle it such that comparisons are not neccessary
    2. If the protocol is there to help inject functionality, that functionality should probably be refactored out of the protocol and put into a handler construct so that the value type can just be a value.
3. If you're using a Protocol to compare a value type to an object type then you probably need to take a step back and look at the design decisions that led you here.
