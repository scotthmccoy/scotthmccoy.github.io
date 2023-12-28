Run this at the root of the project to see which files are being ignored and why:
`git check-ignore -v **/*`

A `.gitignore` at the project root is common, but you can also sprinkle them throughout a project's structure. This can make ignoring specific patterns in a specific subdirectory a lot easier to manage without having to do wild regex stuff.

A good pattern is to make an entry in the root gitignore with the path to the directory you want to override:
`!SpecialDirectory/**`

And then in `SpecialDirectory` make a new gitignore that can be cleanly applied to its subdirectories without interferance from the root .gitignore.
