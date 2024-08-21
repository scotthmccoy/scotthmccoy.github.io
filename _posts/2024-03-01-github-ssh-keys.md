Note that most key issues with github enterprise don't require you to re-issue keys, just restart the server, so start with that.

# How to update github ssh keys

1. Delete the old keys from github

2. Run the following:

    `ssh-keygen -t ed25519 -C "scott.mccoy@vrtcal.com"`

3. Name the file according to the usage & date so you can tell the keys apart:

    `/Users/scottmccoy/.ssh/vrtcal_2024_03_01`

4. Add the private key to ssh agent:

    `ssh-add --apple-use-keychain ~/.ssh/vrtcal_2024_03_01`

5. Add the key to ssh config so that the key will be added to ssh agent upon next reboot:
   `touch ~/.ssh/config`
   Then, add the following to ~/.ssh/config:
   ```
   Host github.com
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/vrtcal_2024_03_01
   ```

6. Cat the public key (the .pub one) out and copy it

    `cat /Users/scottmccoy/.ssh/vrtcal_2024_03_01.pub`

7. Paste it into github

    `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP/SuWM4Tv0cwp82Jj89FAj2Tn3CEy67g2t0wj/g78e7 scott.mccoy@vrtcal.com`

8. Test the connection

    `ssh -T git@github.vrtcal.com`
