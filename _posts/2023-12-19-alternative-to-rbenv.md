I have had little success on MacOS getting a decent ruby environment going: https://xkcd.com/1987/

RVM is an alternative to rbenv:

```
curl -sSL https://get.rvm.io | bash -s stable
curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
echo "source $HOME/.rvm/scripts/rvm" >> ~/.zprofile
# This fixes an issue with openssl: https://github.com/rbenv/homebrew-tap/issues/9 https://github.com/sidneys/homebrew-homebrew/issues/23
rvm install 3.2.2 --with-openssl-dir=$(brew --prefix openssl@1.1)
```

