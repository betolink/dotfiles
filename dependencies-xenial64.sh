#!/bin/sh
# WARNING: Meant to work on Ubuntu 16.04 LTS, this is not an unattended script
# General dependencies
sudo apt-get update && sudo apt-get install --no-install-recommends -y make git zsh build-essential \
htop libssl-dev zlib1g-dev libreadline-dev libsqlite3-dev libncurses5-dev pkg-config silversearcher-ag \
libncursesw5-dev bzip2 libbz2-dev llvm software-properties-common libevent-dev libtool automake xclip

# oh-my-zsh
sudo sed -i -e 's/required/sufficient/g' /etc/pam.d/chsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "export SHELL=/bin/zsh" >> ~/.profile
echo "exec /bin/zsh -l" >> ~/.profile

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update && apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo usermod -aG docker $USER

# tmux
wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
tar -zxvf tmux-2.6.tar.gz
cd tmux-2.6 && ./configure && make
sudo make install

# dot files
cd ~ && git clone https://github.com/betolink/dotfiles.git

mkdir -p ~/.config/
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" \
https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

# Pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
# Node
curl -L https://git.io/n-install | bash -s -- -y
# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
cd ~/.rbenv && src/configure && make -C src

# Neovim
sudo add-apt-repository -y ppa:neovim-ppa/stable
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
