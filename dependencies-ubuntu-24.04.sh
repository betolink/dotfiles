#!/bin/sh
# Updated for Ubuntu 24.04, TODO: make it unattended
sudo apt update && sudo apt install --no-install-recommends -y make git zsh build-essential \
htop libevent-dev libtool automake silversearcher-ag xclip libncurses5-dev libssl-dev libreadline-dev \
zlib1g-dev libbz2-dev libzip-dev bzip2 vim tmux ca-certificates curl software-properties-common \
nload jq chafa

# glow for md on terminal
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install glow

# docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# oh-my-zsh
sudo sed -i -e 's/required/sufficient/g' /etc/pam.d/chsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# nord
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

# dot files
cd ~ && git clone https://github.com/betolink/dotfiles.git

# fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && git clone https://github.com/powerline/fonts.git --depth=1

# Pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Node
curl -L https://git.io/n-install | bash -s -- -y

# Rust
curl https://sh.rustup.rs -sSf | sh

# Neovim v0.10
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update && sudo apt-get install -y neovim

# LunarVim
LV_BRANCH='release-1.3/neovim-0.10' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.10/utils/installer/install.sh) -y

# Configure dotfiles
cd ~/.config && rm -rf nvim || true && ln -s ~/dotfiles/neovim nvim
cd ~ && rm ~/.zshrc || true && ln -s ~/dotfiles/zsh/.zshrc .zshrc
cd ~ && rm .tmux.conf || true && ln -s ~/dotfiles/tmux/.tmux.conf .tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

exit 0
