Finds all .h and .m files, sorts them by number of lines in the file:
```
find . | grep "\\.h$" | grep -v Tuist | grep -v Tools | grep -v vendor | tr \\n \\0 | xargs -0 wc -l | sort
find . | grep "\\.m$" | grep -v Tuist | grep -v Tools | grep -v vendor | tr \\n \\0 | xargs -0 wc -l | sort
```
