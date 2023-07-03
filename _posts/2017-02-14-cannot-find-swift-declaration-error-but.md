
This seems like it's an issue with Framework search paths not being able to find the .swiftmodule files when a relative path is used.

This guy discovered that spaces in the path make it break: https://forums.developer.apple.com/thread/46904

But it seems like relative paths *at all* cause the issue.
