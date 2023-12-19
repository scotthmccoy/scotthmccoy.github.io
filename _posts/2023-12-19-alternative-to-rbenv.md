Alternative to rbenv

#RVM approach
curl -sSL https://get.rvm.io | bash -s stable
curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
echo "source $HOME/.rvm/scripts/rvm" >> ~/.zprofile

# which rvm after this will print a ruby function definition

rvm install 3.2.2
