
```
func fizzBuzzBang(number: Int) -> String {
    switch (number % 3, number % 5, number % 7) {
    case (0, 0, 0):
        // number divides by both 3, 5 and 7
        return "FizzBuzzBang!"
        
    case (0, 0, _):
        // number divides by both 3 and 5
        return "FizzBuzz!"
        
    case (0, _, 0):
        // number divides by both 3 and 7
        return "FizzBang!"
        
    case (_, 0, 0):
        // number divides by 5 and 7
        return "BuzzBang!"
        
    case (0, _, _):
        // number divides by 3
        return "Fizz!"
        
    case (_, 0, _):
        // number divides by 5
        return "Buzz!"
        
    case (_, _, 0):
        // number divides by 7
        return "Bang!"
        
    case (_, _, _):
        // number does not divide by either 3 or 5
        return "\(number)"
        
    default:
        return "Foo"
    }
}
```
