# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Remapping ><
#

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

# alias tmux="env TERM=xterm-256color tmux"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history-substring-search debian node npm rbenv vagrant tmux docker docker-compose conda-zsh-completion ansible)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Alias
alias nt="lsof -i tcp -sTCP:ESTABLISHED"
alias pg="ps -aux | grep "
alias bigfiles="sudo find / -xdev -type f -size +100M -exec du -sh {} ';' | sort -rh | head -n50"
alias vm="vagrant nsidc"
alias gittree="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/beto/.pyenv/versions/miniconda3-latest/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/beto/.pyenv/versions/miniconda3-latest/etc/profile.d/conda.sh" ]; then
        . "/home/beto/.pyenv/versions/miniconda3-latest/etc/profile.d/conda.sh"
    else
        export PATH="/home/beto/.pyenv/versions/miniconda3-latest/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

export PATH="$HOME/.poetry/bin:$PATH"
