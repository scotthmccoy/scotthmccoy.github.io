
On the machine you are logging in FROM, type the following and answer yes to all questions:
`ssh-keygen -t dsa`

Do not try to copy and paste the public key manually! Though it’s a string sometimes strange things will happen to certain characters when you copy-paste it via the terminal. Instead, use `ssh-copy-id`. Type the following and enter the password:
`ssh-copy-id -i ~/.ssh/id_dsa.pub root@activision1`

Now, SSH into the target server. If you are not prompted with a password then everything is working correctly.
`ssh root@activision1`

Make sure that the .ssh directory and everything in it is chmodded 600, otherwise anyone can edit it.

You can try looking at the logs in `/var/log/messages` or `/var/log/secure` or `var/log/auth`

To pass commands to ssh remotely, do this:
`ssh login@ip command_you_want`

example:
`ssh root@linuxdev3 ls -l`
