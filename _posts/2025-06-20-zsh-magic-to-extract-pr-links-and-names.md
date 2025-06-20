Links:
```
cat prs.html | grep Link--primary | sort | uniq | sed -r 's/.*href="([^"]+).*/\1/g' | sed 's/^/http:\/\/github.com/'
```

Titles:
```
cat prs.html | grep Link--primary | uniq | sed -r 's/.*>([^<]+)<\/a>/\1/g'
```
