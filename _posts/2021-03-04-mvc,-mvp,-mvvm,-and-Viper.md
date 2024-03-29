# MVC
1. Views are just bags of properties that the Controller has to know a lot about and update directly, like grabbing a particular textField by its ID and setting its string value.
2. The View and Controller are so tightly coupled that the code of one is rarely modified without affecting the other.
3. MVC works best with a very robust, fully fleshed-out Model and the discipline to maintain its robustness over time. It's easy for the Controller to slowly accumulate business logic, making it bloated and brittle.

Note: The second article mentions that MVC implies that the view has direct access to the Model which I've only ever seen done as a hack or mistake.

# MVP
1. The View's properties are now private and it gates access to them via an implemented interface/protocol. Instead of fighting the natural tendency for the View/ViewController (iOS) or View/Activity (Android) to go hand-in-hand, we lean into it instead.
2. The Controller has been re-branded to Presenter and is much more abstract. It can interact with any object that implements the interface, and uses it to tell the view what to display instead of how. This means it is much more testable! In a Unit Test you can init a Presenter with a MockView that implements the expected protocol.
3. The Presenter uses as little as possible in the way of Android or iOS specific APIs.
4. Like MVC, MVP needs a robust model and the discipline to maintain its separate areas of concern or else the Presenter bloats up.

# VIPER
View, Interactor, Presenter, Entity, Router
1. The View is a UIView, but is intended to be directly manipulated by the Presenter. Like other patterns the View is now intended to be as dumb as possible. 
2. The Interactor talks to data-providing services, typically over the internet and provides Entity objects to the Presenter. This seems like a nice carve-out from the vaugely described "Model" of other patterns. 
3. The Presenter is a "UIKit-Independent Mediator". The Presenter seems to be analogous to a ViewModel in MVVM as it acts as event handler for the View.
4. The Entities are models used by the Interactor.
5. The Router is now the entry point, creating Presenters as needed and handling the logic for when to push and pop VCs from your navigation stack.

According to [VIPER For SwiftUI? Please. No.](https://betterprogramming.pub/viper-for-swiftui-please-no-ee61ce99694c), Micheal Long argues that while VIPER is a great architecture, it's a terrible fit for SwiftUI:

1. It relies way too much on the Delegate pattern, probably because that was the style at the time ([June 2014](https://www.objc.io/issues/13-architecture/viper/))
2. In SwiftUI, since a View is a struct, not a class, the Presenter can't hold a _reference_ to one.
3. It was an answer to the wrong question, "How Do We Fix Massive-ViewController?", instead of "Why is the VC so large in the first place?".

He asserts that MVC made for large ViewControllers because UIKit makes composition hard; that doing something like as adding a Popover in UIKit requires a clunky maze of NavigationControllers, Xib creation, popOverViewControllerDidDoAThing delegate messaging and so forth. SwiftUI makes it much, much easier to just compose a view and pass its subviews a reference to the ViewModel.

He also says that VIPER achieves its ends by over-focusing on the Single Responsibility Principle. It decomposes the Massive View Controller anti-pattern into perhaps _too many_ pieces to the point that a significant percentage of the app's code exists just to manage VIPER, and proposes that perhaps a code generator should be used. This makes sense, since VIPER seems to be an attempt to fulfill on Clean Architecture from Uncle Bob (who I consider to be [problematic, dogmatic, and somewhat outdated](https://scotthmccoy.github.io/2023/12/27/uncle-bob-considered-harmful.html)), and Bob has long had a tendency to promote decomposition to a somewhat absurd degree.

On [https://www.reddit.com/r/iOSProgramming/comments/5pcebg/comment/dcqa1uj/], n0damage says "VIPER is what happens when former enterprise Java programmers invade the iOS world. It imposes so much abstraction and structure that maintainability of code is reduced, not improved."

# MVVM
1. The View is now the entry point to the application instead of a middleman object.
2. The Presenter/Controller has been rebranded again, this time to ViewModel. It is now owned by the _view_ and explicitly uses the Observer design pattern, making it more reactive (if not outright reactive).
3. The ViewModel does not have a reference to the View. Instead, the View watches the ViewModel's observable fields for updates and uses its own logic for deciding how to show those changes, typically through Data Bindings. In return, the ViewModel exposes functions that the View can call to handle user interactions.
4. Critically, this means that the View *does not have to be mocked at all*! When testing, you only need to verify that the observable variables are set appropriately on the ViewModel when the Model changes, and how the ViewModel responds to its user interaction methods. There is no need to mock out the view for testing as there was with the MVP pattern. 🤯 Testing of the View is deferred to UI Tests/Integration tests.
5. The View is often constructed using a declarative syntax: Android's Layout XML or SwiftUI's Views, VStacks and so forth.






