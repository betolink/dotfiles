Neovim plugins and init.vim files go under .config/nvim/

NERDfonts need to be installed:

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf

for neoplete python:

pip2 install --user neovim
pip3 install --user Neovim

With VirtualEnvs set the following paths in init.vim:

let g:python_host_prog = '/full/path/to/neovim2/bin/python'
let g:python3_host_prog = '/full/path/to/neovim3/bin/python'

For other languages:

https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources