1. Default to using a struct.
2. Use a class when you need inheritance or reference functionality (like implementing the Observer pattern).
3. Use an enum when you don’t want to instantiate it. For example, defining Combine publishers can be done on an enum.
