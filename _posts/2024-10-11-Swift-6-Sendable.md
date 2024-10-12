I think I'm starting to get it.

Since AnyPublisher isn't Sendable, it simply can't cross an actor boundary, period. Even if you:

1. Make it @MainActor and set it in the init
<img width="914" alt="image" src="https://github.com/user-attachments/assets/8cbdd826-b9c9-45ae-ac87-4a517f65085b">

2. Put the creation/access in an @MainActor func
<img width="911" alt="image" src="https://github.com/user-attachments/assets/7dc60597-6a75-4562-80c4-4ba4fcfd88a7">

3. Put the creation/access in an actor func
<img width="933" alt="image" src="https://github.com/user-attachments/assets/2f26cd1d-d054-48a0-b854-fb50fab221cf">

4. Create a GlobalActor of that actor and access the property in a @GlobalActor'd func 🤬. Seems GlobalActors are useful for having multiple _classes_ run on the same executor - say, a cache and a database.
<img width="732" alt="image" src="https://github.com/user-attachments/assets/72437197-b782-47de-b3f1-63fd5d2940cd">

5. Use a delegate??? Haven't tried this.

And since AsyncStream and AsyncCollection aren't Sendable either, there's just not a very good way to expose 

Seems like Actors are good for specifically being CRUD-based in-memory data stores or fetch-and-transform operators; they probably work best in a has-a relationship where your Repository exposes implements observability somehow and uses an actor to guarantee data safety. They're remind me of Erlang's design conceits - rock solid, fast and highly availabile. Though, I suppose Erlang's fault tolerance comes from a DGAF approach to failure rather just making sure that nothing can data-race, but the vibes are the same.









