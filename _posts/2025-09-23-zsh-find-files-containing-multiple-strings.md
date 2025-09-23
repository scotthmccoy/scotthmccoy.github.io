```
grep -rl listingInteractionTracker EtsyApp | sort | uniq > files.txt; cat files.txt | tr \\n \\0 | xargs -0 grep -l LazyVStack; say done
```

Notes:
- `grep -l` only prints the filename instead of also including the matching line. This gets us a list of matching files.
- This creates an output file, `files.txt` for the output of the first search (which is typically a fairly long wait) so subsequent searches can go much faster.
- Make sure to do this one directory above where you are searching or the search will include the output file. In this case, we're searchig EtsyApp but searching from the parent directory, XCodeProjects.
- This uses the `tr` trick for dealing with spaces in filenames in MacOS/zsh.
- Lastly, we `say done` at the end so you get an audible alert.

