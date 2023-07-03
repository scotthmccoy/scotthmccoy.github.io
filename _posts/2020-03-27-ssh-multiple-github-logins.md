
To simplify access on github it’s a great idea to use ssh keys for authentication. To add one, click on your user, then settings, then SSH and GPG Keys, or just go to https://github.com/settings/keys.
However, Github does not support multiple accounts sharing the same ssh key. One way to get around this is to create multiple entries in your ssh config file:

~/.ssh/config

```
#personal account
Host scotthmccoy-github
HostName github.com
Port 22
User git
IdentityFile ~/.ssh/id_rsa

#Vrtcal Github Enterprise account
Host vrtcal-github
HostName github.vrtcal.com
User git
IdentityFile ~/.ssh/id_rsa_vrtcal

#vrtcalsdkdev account
Host vrtcalsdkdev-github
HostName github.com
Port 22
User git
IdentityFile ~/.ssh/id_rsa_vrtcalsdkdev

#scott-mccoy-modolabs account
Host scott-mccoy-modolabs-github
HostName github.com
Port 22
User git
IdentityFile ~/.ssh/id_rsa_scott-mccoy-modolabs-github
```

Test the connection on each account:
```
scottmccoy@Scotts-MBP-M1 .ssh % ssh -T git@github.com
Hi scotthmccoy! You've successfully authenticated, but GitHub does not provide shell access.

scottmccoy@Scotts-MBP-M1 .ssh % ssh -T git@vrtcal-github              
Hi scott! You've successfully authenticated, but GitHub does not provide shell access.

scottmccoy@Scotts-MBP-M1 .ssh % ssh -T git@vrtcalsdkdev-github
Hi vrtcalsdkdev! You've successfully authenticated, but GitHub does not provide shell access.

scottmccoy@Scotts-MBP-M1 .ssh % ssh -T git@scott-mccoy-modolabs-github
Hi scott-mccoy-modolabs! You've successfully authenticated, but GitHub does not provide shell access.
```


Then refer to the repo like so:
`ssh://vrtcalsdkdev-github/vrtcalsdkdev/VrtcalSDK.git`
![]({{ site.url }}/images/multiple_ssh_github.png)
