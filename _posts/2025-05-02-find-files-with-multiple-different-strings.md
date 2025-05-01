Example with 2 strings:
```
grep -rl "String 1" | tr \\n \\0 | xargs -0 grep -l "String 2"
```

Example with 3 strings:
```
grep -rl "String 1" | tr \\n \\0 | xargs -0 grep -l "String 2" | tr \\n \\0 | xargs -0 grep -l "String 3"
```
