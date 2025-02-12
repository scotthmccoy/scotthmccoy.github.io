# MVC
Trygve Reenskaug created [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) in the late 1970's while working on Smalltalk-79 as a visiting scientist at the Xerox Palo Alto Research Center (PARC).

1. Views are just bags of properties that the Controller has to know a lot about and update directly, like grabbing a particular textField by its ID and setting its string value.
2. The View and Controller are so tightly coupled that the code of one is rarely modified without affecting the other.
3. MVC works best with a very robust, fully fleshed-out Model and the discipline to maintain its robustness over time. It's easy for the Controller to slowly accumulate business logic, making it bloated and brittle.

# MVP
The [MVP](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) software pattern originated in the early 1990s at Taligent, a joint venture of Apple, IBM, and Hewlett-Packard.

1. The View's properties are now private and it gates access to them via an implemented interface/protocol. Instead of fighting the natural tendency for the View/ViewController (iOS) or View/Activity (Android) to go hand-in-hand, we lean into it instead.
2. The Controller has been re-branded to Presenter and is much more abstract. It can interact with any object that implements the interface, and uses it to tell the view what to display instead of how. This means it is much more testable! In a Unit Test you can init a Presenter with a MockView that implements the expected protocol.
3. The Presenter uses as little as possible in the way of Android or iOS specific APIs.
4. Like MVC, MVP needs a robust model and the discipline to maintain its separate areas of concern or else the Presenter bloats up.

# VIPER
The earliest reference to VIPER that I could find is [this 2014 article](https://www.objc.io/issues/13-architecture/viper/). It's an attempt to apply Robert Martin's Clean Architecture (2008) to iOS.

View, Interactor, Presenter, Entity, Router
1. The View is a UIViewController+UIView. It is intended to be directly manipulated by the Presenter. Like other patterns the View is now intended to be as dumb as possible. 
2. The Presenter is where the bloat happens. It talks to the View, The Router and the Interactor. It is a "UIKit-Independent Mediator"; it doesn't know anything about how UIKit works. The Presenter seems to be analogous to a ViewModel in MVVM as it acts as event handler for the View. 
3. The Interactor owns the business logic (What Clean Architecture called the "Use Cases") and talks to data-providing services (API, Database, etc). The interactor doesn't deal with  Entity objects to the Presenter. This explicit home for business logic (AKA the "Use Cases" in Clean Architecture) honestly seems like a nice carve-out from the vaugely described "Model" of other patterns. 
4. The Entities are models used by the Interactor - Database, Cache, API, etc.
5. The Router is now the entry point, creating Presenters as needed and handling the logic for when to push and pop VCs from your navigation stack. In SwiftUI, this can be 

### Praise for VIPER
Though VIPER was invented before SwiftUI, it actually works quite well with it. A Presenter can @Publish to a View and a Router can be implemented as a NavigationView that switches on a singleton enum state to determine which View is shown to the user:

![image](https://github.com/user-attachments/assets/162023fd-d7f2-4f21-8f09-ae0a7e768fcd)
Credit to [This Guy's](https://www.youtube.com/watch?v=REggLXHMAqQ) video on how to make a Router work in SwiftUI.

I also used to think that VIPER was dogmatic and over-engineered, but for any app more complex than KD Scoring, I now think it's actually a pretty great fit. 

- I actually really _like_ the idea of decoupling navigation logic from the View - it gives you a bird's eye view into the navigation flow of your app instead of having to sus it out from storyboards, segues and NavigationLinks.
- I also really like having business logic confined to Interactors (and therefor having the biz logic itself being individually testable) rather than having biz logic be sprinkled throughout the Repository - this lets the Repo be a _very_ simple CRUD Facade. I haven't tried this out yet but I suspect that it'd be nice in practice.
- I was already standardizing to having a Data/Domain Object split in all my projects, but VIPER's "E" seems to heavily imply that your Data Layer only emits domain objects, not NSManagedObjects or whatever. 

### Criticism of VIPER:
- On [/r/iOSProgramming](https://www.reddit.com/r/iOSProgramming/comments/5pcebg/comment/dcqa1uj/), n0damage says "VIPER is what happens when former enterprise Java programmers invade the iOS world. It imposes so much abstraction and structure that maintainability of code is reduced, not improved."
- [VIPER For SwiftUI? Please. No.](https://betterprogramming.pub/viper-for-swiftui-please-no-ee61ce99694c)


# Clean Architecture, Hexagonal Architecture and Ports & Adapters
It's widely accepted that Robert Martin's Clean Architecture (2008) is just a rebranding of Hexagonal Architecture (AKA "Ports and Adapters" by Dr. Alistair Cockburn, 2005). Martin essentially admits to this on his [blog](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html):

> "The diagram at the top of this article [Clean Architecture] is an attempt at integrating all these architectures [including Hexagonal, Onion, etc] into a single actionable idea."

Clean, Hex and P&A all say to decouple your architecture into 3 layers: 
- a data fetch/store layer
- a business logic layer
- a presentation layer

Hex/P&A explicity says to use interfaces ("ports") and concrete implementations ("adapters") to accomplish this. Clean Architecture asserts that there should also be Entities (which seems to be a given? How else are you going to marshall data around your application?) and Use Cases where all your business logic lives.


# MVVM
John Gossman, a Microsoft WPF and Silverlight architect, announced [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) on his blog in 2005, but it wasn't widely acknowledged as a healthy architecture pattern on iOS until SwiftUI/Combine allowed for proper data bindings.

1. The View is now the entry point to the application instead of a middleman object.
2. The Presenter/Controller has been rebranded again, this time to ViewModel. It is now owned by the _view_ and explicitly uses the Observer design pattern, making it more reactive (if not outright reactive).
3. The ViewModel does not have a reference to the View. Instead, the View watches the ViewModel's observable fields for updates and uses its own logic for deciding how to show those changes, typically through Data Bindings. In return, the ViewModel exposes functions that the View can call to handle user interactions.
4. Critically, this means that the View *does not have to be mocked at all*! When testing, you only need to verify that the observable variables are set appropriately on the ViewModel when the Model changes, and how the ViewModel responds to its user interaction methods. There is no need to mock out the view for testing as there was with the MVP pattern. 🤯 Testing of the View is deferred to UI Tests/Integration tests.
5. The View is often constructed using a declarative syntax: Android's Layout XML or SwiftUI's Views, VStacks and so forth.


# TCA (The Composable Architecture) 
Composable architecture has origins in the concepts of composable commerce, service-oriented architecture (SOA), and APIs. It's also based on the idea of building applications from interchangeable building blocks.

Gartner coined the term "composable commerce" in [June 2020](https://www.gartner.com/en/documents/3986490).

[The Composable Architecture (TCA)](https://www.pointfree.co/collections/composable-architecture) library was developed by Point-Free to help developers build applications using SwiftUI.
