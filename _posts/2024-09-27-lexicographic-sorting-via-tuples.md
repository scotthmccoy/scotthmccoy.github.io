This sorts dayOfMonth and title ascending, and value descending
```
extension RecurringTransaction: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        (lhs.dayOfMonth, lhs.title, rhs.value)
        <
        (rhs.dayOfMonth, rhs.title, rhs.value)
    }
}
```
