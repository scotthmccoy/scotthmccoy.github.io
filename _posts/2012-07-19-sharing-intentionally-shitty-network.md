
http://joemiller.me/2010/08/31/simulate-network-latency-packet-loss-and-bandwidth-on-mac-osx/   

```
# Create 2 pipes and assigned traffic to and from our webserver to each:
$ sudo  ipfw add pipe 1 ip from any to 10.0.0.1
$ sudo  ipfw add pipe 2 ip from 10.0.0.1 to any
 
# Configure the pipes we just created:
$ sudo  ipfw pipe 1 config delay 250ms bw 1Mbit/s plr 0.1
$ sudo  ipfw pipe 2 config delay 250ms bw 1Mbit/s plr 0.1





$ ping 10.0.0.1
PING 10.0.0.1 (10.0.0.1): 56 data bytes
64 bytes from 10.0.0.1: icmp_seq=0 ttl=63 time=515.939 ms
64 bytes from 10.0.0.1: icmp_seq=1 ttl=63 time=519.864 ms
64 bytes from 10.0.0.1: icmp_seq=2 ttl=63 time=521.785 ms
Request timeout for icmp_seq 3
64 bytes from 10.0.0.1: icmp_seq=4 ttl=63 time=524.461 ms





$sudo  ipfw list |grep pipe
  01900 pipe 1 ip from any to 10.13.1.133 out
  02000 pipe 2 ip from 10.13.1.133 to any in
$ sudo  ipfw delete 01900
$ sudo  ipfw delete 02000
 
# or, flush all ipfw rules, not just our pipes
$ sudo ipfw -q flush
```
