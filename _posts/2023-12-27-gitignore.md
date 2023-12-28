Use the following to find out _why_ a file is being ignored:
`git check-ignore -v *`

A `.gitignore` at the project root is common, but you can also sprinkle them throughout a project's structure. This can make ignoring specific patterns in a specific subdirectory a lot easier to manage without having to do wild regex stuff.
