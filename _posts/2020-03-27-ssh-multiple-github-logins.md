---
layout: post
title: 
date: '2020-03-27T17:54:47-0700'
author: Scott McCoy
tags: 
modified_time: '2020-03-27T17:54:47-0700'
---

To simplify access on github it’s a great idea to use ssh keys for authentication. To add one, click on your user, then settings, then SSH and GPG Keys, or just go to https://github.com/settings/keys.
However, Github does not support multiple accounts sharing the same ssh key. One way to get around this is to create multiple entries in your ssh config file:

~/.ssh/config

```
#Vrtcal Github Enterprise account
Host github.vrtcal.com
HostName github.vrtcal.com
User git
IdentityFile ~/.ssh/id_rsa

#personal account
Host scotthmccoy-github
HostName github.com
Port 22
User git
IdentityFile ~/.ssh/id_rsa

#vrtcalsdkdev account
Host vrtcalsdkdev-github
HostName github.com
Port 22
User git
IdentityFile ~/.ssh/id_rsa_vrtcalsdkdev
```

Test the connection on each account:
```
scotts-mbp:ios-sdk scottmccoy$ ssh -T git@vrtcalsdkdev-github
Hi vrtcalsdkdev! You've successfully authenticated, but GitHub does not provide shell access.
```

```
scotts-mbp:ios-sdk scottmccoy$ ssh -T git@scotthmccoy-github
Hi scotthmccoy! You've successfully authenticated, but GitHub does not provide shell access.
```


Then refer to the repo like so:
![]({{ site.url }}/images/multiple_ssh_github.png)
