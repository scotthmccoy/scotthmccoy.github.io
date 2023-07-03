
```
cd /
du -k |  awk '$1 &gt; 500000' | sort -nr
```
