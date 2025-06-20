
```
#!/usr/bin/env zsh
cat prs.html | grep Link--primary | sort | uniq | sed -r 's/.*href="([^"]+).*/\1/g' | sed 's/^/http:\/\/github.com/' > tmp_links.txt
cat prs.html | grep Link--primary | uniq | sed -r 's/.*>([^<]+)<\/a>/\1/g' > tmp_titles.txt
paste tmp_links.txt tmp_titles.txt > columns.txt

rm tmp_links.txt
rm tmp_title.txt

echo "Copy the contents of columns.txt from a text editor and paste into Sheets"
```
