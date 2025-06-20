Links:
```
cat prs.html | grep Link--primary | uniq | sed -r 's/.*>([^<]+)</\1/g' > foo.txt
```

Titles:
```
cat prs.html | grep Link--primary | uniq | sed -r 's/.*>(.+)<\/a>/\1/g' > foo.txt
```
