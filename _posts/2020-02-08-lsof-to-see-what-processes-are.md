
`sudo lsof -i -P -n | grep LISTEN` 

If it doesn't use an \* in the rightmost column then the listed host is the only one with access

```
launchd       1           root    9u  IPv6 0xd9193bc4a48ae439      0t0    TCP *:49152 (LISTEN)
launchd       1           root   25u  IPv6 0xd9193bc4a48ae439      0t0    TCP *:49152 (LISTEN)
rapportd    920     scottmccoy    6u  IPv4 0xd9193bc970d46101      0t0    TCP *:59670 (LISTEN)
rapportd    920     scottmccoy    9u  IPv6 0xd9193bc4b13fdd59      0t0    TCP *:59670 (LISTEN)
ControlCe  8919     scottmccoy   13u  IPv6 0xd9193bc4a48af1f9      0t0    TCP *:7000 (LISTEN)
ControlCe  8919     scottmccoy   18u  IPv4 0xd9193bc970d840b1      0t0    TCP *:7000 (LISTEN)
ControlCe  8919     scottmccoy   19u  IPv4 0xd9193bc970d800b1      0t0    TCP *:5000 (LISTEN)
ControlCe  8919     scottmccoy   20u  IPv6 0xd9193bc4a48af8d9      0t0    TCP *:5000 (LISTEN)
Google    29047     scottmccoy  122u  IPv4 0xd9193bc970d76b91      0t0    TCP 127.0.0.1:51963 (LISTEN)
Adobe\x20 29941     scottmccoy   17u  IPv4 0xd9193bc970d715d1      0t0    TCP 127.0.0.1:15292 (LISTEN)
Adobe\x20 29941     scottmccoy   20u  IPv4 0xd9193bc9719540b1      0t0    TCP 127.0.0.1:15393 (LISTEN)
Adobe\x20 29941     scottmccoy   22u  IPv4 0xd9193bc970d4d5d1      0t0    TCP 127.0.0.1:16494 (LISTEN)
node      35937     scottmccoy   32u  IPv4 0xd9193bc970d655d1      0t0    TCP 127.0.0.1:55767 (LISTEN)
node      35937     scottmccoy   33u  IPv4 0xd9193bc971956101      0t0    TCP 127.0.0.1:55768 (LISTEN)
node      35937     scottmccoy   36u  IPv4 0xd9193bc9712da101      0t0    TCP 127.0.0.1:45623 (LISTEN)
node      35937     scottmccoy   37u  IPv4 0xd9193bc9712dcb41      0t0    TCP 127.0.0.1:56122 (LISTEN)
node      58449     scottmccoy   22u  IPv6 0xd9193bc4b278e439      0t0    TCP *:8080 (LISTEN)
```



 
