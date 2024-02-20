From https://www.youtube.com/watch?v=OpJcInSZpc8&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=16:

Sarno’s Pattern - https://www.youtube.com/watch?v=OpJcInSZpc8&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=16

```
//////////////////
// The Model Layer
//////////////////

// We can use either an actor or class here. I think I would have named this FooRepository.
final class MyManagerClass {
	func getData() -> async throws -> String {
		"Some Data"
	}
}

actor MyManagerActor {
	func getData() -> async throws -> String {
		"Some Data"
	}
}

///////////////////////
// The ViewModel Layer
///////////////////////
// Since the ViewModel's job is to update the view, we run the whole thing on the MainActor.
@MainActor
final class FooViewModel: ObservableObject {
	
	// We can use either an actor or class here
	let managerClass = MyManagerClass()
	let myManagerActor = MyManagerActor()

	// An array of tasks with no success value and no failure value
	private var tasks:[Task<Void, Never>]

	@Published private(set) var myData: String = "Starting Text"

	func onCallToActionButtonPressed() {
		/*
		Intentionally use tasks inside viewmodel funcs instead of the UI. The intent behind this is so that the UI can be synchronous, 
		which seems to be in keeping with the MVVM principle of "Keep the view as dumb as possible".
		A commenter noted that using tasks does, however, make it much harder to unit test the viewModel since the tests

		Sarno says it's not *bad* to use Tasks in the View instead (such as when you might want a viewModel func to return 
		something).
		*/

		// Create a task and append it to the array so that they can be cancelled if need be
		let task = Task {
			do {
				myData = try await myManagerClass.getData()
			} catch {
				// Handle errors here so that tasks can stay of type Task<Void, Never>
				print(error)
			}
		}
		tasks.append(task)
	}

	func cancelTasks() {
		tasks.forEach {
			$0.cancel()
		}
		tasks = []
	}
}

///////////////////////
// The View Layer
///////////////////////
struct FooView {
	// Note: If the viewmodel is stateful, it needs to get passed in during init or else every time the view
	// invalidates it will be re-created
	@StateObject private var viewModel = FooViewModel()

	var body: some View {
		Button("Click Me") {
			viewModel.onCallToActionButtonPressed()
		}
		.onDisappear {
			viewModel.cancelTasks()
		}
	}
}
```
