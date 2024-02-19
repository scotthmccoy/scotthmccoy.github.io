From https://www.youtube.com/watch?v=OpJcInSZpc8&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=16:

```
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

final class FooViewModel: ObservableObject {
	
	let managerClass = MyManagerClass()
	let myManagerActor = MyManagerActor()
}

struct FooView {
	// Note: This needs to be passed in or else the VM gets re-made each time the view invalidates
	@StateObject private var viewModel = FooViewModel()
}
```
