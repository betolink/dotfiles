#!/bin/sh

# default python version
pyenv install 3.6.5
pyenv global 3.6.5

pip3 install --upgrade neovim

# default ruby version
rbenv install 2.5.0
rbenv global 2.5.0

# js
npm update -g npm
npm install -g yarn


nvim +PlugInstall +qall
nvim +UpdateRemotePlugnis +qall

cd ~ && source .zshrc
exit 0
