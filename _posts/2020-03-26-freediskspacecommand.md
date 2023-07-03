
Sometimes when installing new versions of software, the path that bash has saved gets corrupted. Running the hash command on that command can fix it, or just running hash -r


```
[lunchvote@server /]$ node
-bash: /usr/local/bin/node: No such file or directory
hash node
[lunchvote@server /]$ node --version
v10.18.1
```
