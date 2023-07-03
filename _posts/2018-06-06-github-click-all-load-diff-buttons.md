
In Chrome, type `command+opt+J`, then paste the following into the console and hit enter

```
document.querySelectorAll('.load-diff-button').forEach(node => node.click());
document.querySelectorAll('.show-outdated-button').forEach(node => node.click())
```
