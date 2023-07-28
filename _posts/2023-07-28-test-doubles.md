Types of Test Doubles, in ascending order of functionality:

Dummy, Stub, Spy, Mock, Fake

# 🧸 Dummy
Has no functionality; used to satisfy requirements to interact with something.

A better name might be "Placeholder".

For example, if the sut requires a DatabaseProtocol instance to be instantiated but we don't need to test how it actually interacts with the database, we might make a DummyDatabase that does absolutely nothing just to get testing started.

#### Bad Code Smell
Bad. If "doesn't get used" is an expected behavior for the dummy, a more meaningful test would have the Dummy replaced with a Mock that has an expectation that causes a test failure if it is actually interacted with.

Further, if an arg can actually be replaced with a dummy with no loss of usefulness to the test, then either the test coverage is incomplete, or the sut (probably) doesn't meaningfully use the object. 


# 🎫 Stub
Like a dummy, but the vars or function return values are intended to actually get consumed such that we can elicit a *particular* response from the sut.

#### Bad Code Smell
None! Stubs are completely normal.


# 🕵🏻‍♂️ Spy
Like a stub, but it also records information on how it was called or the number of times it was called.

#### Bad Code Smell
Mild. If we care enough to collect data on how our test double *were* used, why not just make them full-on Mocks and make assertions that fail the test if they come out of order as well?


# 🥸 Mock
Like a stub, but also confirms that it was interacted with. Our XCTestCase classes often count as Mocks since we make them conform to a protocol such that they can satisfy dependency requirements of the suts, and fulfill expectations on things like number of times called.

#### Bad Code Smell
None! Mocks are also normal.

# 🤖 Fake
Works just like the real thing but with some shortcuts.

A better name might be "Simulator".

For example, a FakeDatabase might conform to DatabaseProtocol and could be injected into the sut but instead of talking to an actual database it might read/write to a json file instead.

#### Bad Code Smell
The "Unit" in unit test refers to the system under test. A proper unit test isolates the sut so we can make assertions and guarantees about how it interacts with its dependencies. Using a Fake can result in misleading test results as we end up obscuring how the sut is interacting with the dependency in favor of testing how the dependency is *affected* by the interaction; we're essentially testing the Fake's code instead of the sut's!

Fakes also typically require effort to maintain. They might need to be reset between test cases or updated as new versions of the thing they are faking get released.

Sometimes these tradeoffs are useful or neccessary. For example, doing an integration test with a Fake can be a good fit for diagnosing issues that are only emergent after a large number of interactions such as a during a stress test. But, we usually refer to this kind of testing as integration testing rather than unit testing.

But, the presence of Fakes in unit tests usually means something has gone wrong somewhere. It might mean that the sut could use a refactor to decompose it into smaller, more testable components that are less tightly coupled to their dependencies. It might mean that the sut's interactions with its dependencies are nondeterministic; perhaps the result of race conditions. It might mean that the sut *cannot* be refactored, perhaps due to budget limitations or lack of ownership of the sut's code. But, usually it means that the unit test author simply prefers writing integration tests over unit tests.

