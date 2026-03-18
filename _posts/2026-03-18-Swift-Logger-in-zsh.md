If you use the Logger class in swift:
`private let logger = Logger(subsystem: "CloudKitManager", category: "")`

You can do the following in Terminal to watch your logs:
`log stream --process LastWord --predicate 'subsystem contains "Manager"' --info --debug`
