
`command1 && { command2 ; command3 ; command4 ; }`

<br /><br />If the exit status of command1 is true (zero), commands 2, 3, and 4 will be performed.

For example:

```
git stash show -p | git apply && git stash drop
```

Runs `git stash show -p` and pipes it to `git apply && git stash drop`. If `git apply` returns 0, then `git stash drop` runs.

The effect is that only files that are applied *without conflict* are dropped from the stash. (Note: The git command didn't work, but you get the idea with && and ||)
