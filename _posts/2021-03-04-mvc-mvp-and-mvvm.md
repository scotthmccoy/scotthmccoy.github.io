
From [this article](https://academy.realm.io/posts/eric-maxwell-mvc-mvp-and-mvvm-on-android/) and a bit from [this one](https://www.guru99.com/mvc-vs-mvvm.html):

# MVC
1. Views are just bags of properties that the Controller has to know a lot about and update directly, like grabbing a particular textField by its ID and setting its string value.
2. The View and Controller are so tightly coupled that the code of one is rarely modified without affecting the other.
3. MVC works best with a very robust, fully fleshed-out Model and the discipline to maintain its robustness over time. It's easy for the Controller to slowly accumulate business logic, making it bloated and brittle.

Note: This is how I'm used to writing apps. The second article mentions that MVC implies that the view has direct access to the Model which I've only ever seen done as a hack or mistake.

# MVP
1. The View's properties are now private and it gates access to them via an implemented interface/protocol. Instead of fighting the natural tendency for the View/ViewController (iOS) or View/Activity (Android) to go hand-in-hand, we lean into it instead.
2. The Controller has been re-branded to Presenter and is much more abstract. It can interact with any object that implements the interface, and uses it to tell the view what to display instead of how. This means it is much more testable! In a Unit Test you can init a Presenter with a MockView that implements the expected protocol.
3. The Presenter uses as little as possible in the way of Android or iOS specific APIs.
4. Like MVC, MVP needs a robust model and the discipline to maintain it separate areas of concern or else the Presenter bloats up.

# MVVM
1. The View is now the entry point to the application instead of a middleman object.
2. The Presenter/Controller has been rebranded again, this time to ViewModel. It is now owned by the view and explicitly uses the Observer design pattern, making it more reactive (if not outright reactive).
3. The ViewModel does not have a reference to the View. Instead, the View watches the ViewModel's observable fields for updates and uses its own logic for deciding how to show those changes. The ViewModel exposes functions that the View can call to handle user interactions.
4. Critically, this means that the View *does not have to be mocked at all*! When testing, you only need to verify that the observable variables are set appropriately on the ViewModel when the Model changes. There is no need to mock out the view for testing as there was with the MVP pattern. 🤯
5. The View is often constructed using a declarative syntax: Android's Layout XML or SwiftUI's Views, VStacks and so forth.