A ViewModel’s responsibility is to:
1. Translate UI Events from the user into Model interactions
2. Publish data from the Model for the view to Observe
3. Encapsulate this functionality such that it is testable independent of the View (Which it does not reference) and the Model (which does not reference it).

Possibly owing to its origins in other languages/environments, a typical set of expectations of the ViewModel includes that it be:

* An instance member of the View that owns it
* Of a type only used with that View, perhaps being defined as a namespace-child of that View
* Be tightly coupled to the needs of the View 


Example View & ViewModel:

```
struct MyView : View {
	
	@ObservedObject viewModel:ViewModel

	var body : some View {
		Text($viewModel.title)
		Button(“Do Stuff”) {
			viewModel.doStuff()
		}
	}
}

extension MyView {
	class ViewModel : ObservableObject {
		private var data:DataStruct = DataProvider.getData()

		var title:String {
			get {
				return data.title
			}			
			set {
				data.title = newValue
			}
		}
		
		func doStuff() {
			DataProvider.doStuff()
		}
		
		…
	}
}
```


This pattern requires so much boilerplate struct-access code to have to test and maintain that I wonder if it borders on MVVM dogmatism. The code can be simplified to:

```
struct MyView : View {
	
	@ObservedObject var dataProvider = DataProvider.singleton

	var body : some View {
		Text(dataProvider.data.title)
		Button(“Do Stuff”) {
			doStuff()
		}
	}

	func doStuff() {
		dataProvider.doStuff()
	}
}
```

The ViewModel is now “informal”; no longer a separate Type and simply consisting of anything in the View struct that isn’t the `body` var. Note that the “why” of MVVM has not been violated:

* The View is still the entry point to the application and still constructed using a declarative syntax (the `body` var)
* There is no loss of segregation of responsibilities for each design pattern layer: The View still owns the ViewModel, the VM still exposes observable data vars + functions that the View can call to handle user interactions
* There is no loss of independence of design pattern layers: The VM still doesn’t have a reference to the View, and the Model still doesn’t reference the VM
* There is not a loss of testability. The View Struct may be instantiated with a Mock of DataProvider.
* So long as model objects are value types (structs) instead of reference types (classes), letting the View directly access a model struct results in little threat of accidental state manipulation. 

I find that the simpler a View is the less utility there is in having a formal ViewModel. For example, a typical RowView doesn’t deal with dynamic data or respond to user interaction. Since these are the services a ViewModel would provide, it doesn’t need one, formal or otherwise. In fact, while I can think of some use cases where a formal View Model might be a nice-to-have (say, a multipurpose View that can behave differently depending on which ViewModel it is used with) I can’t think of a use case where a formal ViewModel would actually be *required* to make MVVM work.

It does take some added coding discipline to make sure that UI events are properly sent through a func defined on the view struct before being passed to a Model service, but I feel like this added discipline requirement is a small price to pay for a much more streamlined experience.
