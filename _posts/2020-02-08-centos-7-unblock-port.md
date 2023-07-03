
To unblock a port normally you'd use iptables which firewall-cmd is a wrapper for:<br /><br />iptables -I INPUT -p tcp --dport 12345 --syn -j ACCEPT<br />service iptables save