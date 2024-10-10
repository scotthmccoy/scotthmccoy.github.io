
From (StackExchange)[https://softwareengineering.stackexchange.com/questions/371966/is-clean-architecture-by-bob-martin-a-rule-of-thumb-for-all-architectures-or-i]:

> The Clean Architecture is largely Robert C. Martin's re-branding and evolution of related approaches like the Onion Architecture by Jeffrey Palermo (2008) and the Hexagonal Architecture (“Ports and Adapters”) by Alistair Cockburn and others (< 2008).
> 
> Different problems have different requirements. The Clean Architecture and related approaches turn decoupling, flexibility, and dependency inversion up to eleven, but sacrifice simplicity. This is not always a good deal.
> 
> The precursor to these architectures is the classic MVC pattern from Smalltalk. This disentangles the model from the user interface (controller and view), so that the model does not depend on the UI. There are many variations of MVC like MVP, MVVM, ….
> 
> More complex systems do not have just one user interface, but possibly multiple user interfaces. Many apps choose to offer a REST API that can be consumed by any UI, such as a web app or a mobile app. This isolates the business logic on the server from these UIs, so the server doesn't care which kind of app accesses it.
> 
> Typically, the server still depends on backend services such as databases or third party providers. This is perfectly fine, and leads to a simple layered architecture.
> 
> The Hexagonal Architecture goes further and stops making a distinction between frontend and backend. Any external system might be an input (data source) or an output. Our core system defines the necessary interfaces (ports), and we create adapters for any external systems.
> 
> One classic approach for strong decoupling is a service oriented architecture (SOA), where all services publish events to and consume events from a shared message bus. A similar approach was later popularized by microservices.
> 
> All of these approaches have advantages, such as making it easier to test the system in isolation (by replacing all external systems it interfaces with by mock implementations). They make it easier to provide multiple implementations for one kind of service (e.g. adding a second payment processor), or to swap out the implementation of a service (e.g. moving from an Oracle database to PostgreSQL, or by rewriting a Python service in Go).
> 
> But these architectures are the Ferrari of architectures: expensive, and most people don't need them. The added flexibility of the Clean Architecture etc. comes at the cost of more complexity. Many applications and especially CRUD webapps do not benefit from that. It makes sense to isolate things that might change, e.g. by using templates to generate HTML. It makes less sense to isolate things that are unlikely to change, e.g. the backing database. What is likely to change depends on the context and business needs.
> 
> Frameworks make assumptions about what is going to change. E.g. React tends to assume that design and behaviour of a component change together, so it doesn't make sense to separate them. Few frameworks assume that you might want to change the framework. As such, frameworks do present an amount of lock-in. E.g. Rail's reliance on the (very opinionated!) Active Record pattern make it difficult to impossible to change your data access strategy to the (often superior) Repository pattern. If your expectations of change do not match the framework, using a different framework might be better. Many other web frameworks do not make any assumptions about data access.
