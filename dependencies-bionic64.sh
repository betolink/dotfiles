#!/bin/sh
# WARNING: Meant to work on Ubuntu 18.04 LTS, this is not an unattended script
# General dependencies
sudo apt update && sudo apt install --no-install-recommends -y make git zsh build-essential \
htop libevent-dev libtool automake silversearcher-ag xclip libncurses5-dev libssl-dev libreadline-dev \
zlib1g-dev libbz2-dev libzip-dev bzip2 vim
# oh-my-zsh
sudo sed -i -e 's/required/sufficient/g' /etc/pam.d/chsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
TMUX=3.0
# tmux
wget https://github.com/tmux/tmux/releases/download/$TMUX/tmux-$TMUX.tar.gz
tar -zxvf tmux-$TMUX.tar.gz
cd tmux-$TMUX && ./configure && make
sudo make install

# dot files
cd ~ && git clone https://github.com/betolink/dotfiles.git


mkdir -p ~/.local/share/fonts
# fonts
cd .local/share/fonts  && git clone https://github.com/powerline/fonts.git --depth=1

# Pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
# Node
curl -L https://git.io/n-install | bash -s -- -y
# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
cd ~/.rbenv && src/configure && make -C src

# Neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update && sudo apt-get install -y neovim

# neovim plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# configure dotfiles
cd ~/.config && rm -rf nvim || true && ln -s ~/dotfiles/neovim nvim
cd ~ && rm ~/.zshrc || true && ln -s ~/dotfiles/zsh/.zshrc .zshrc
# tmux
cd ~ && rm .tmux.conf || true && ln -s ~/dotfiles/tmux/.tmux.conf .tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

exit 0
