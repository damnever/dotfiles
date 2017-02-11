# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="normal"

# how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=7

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Custom folder than $ZSH/custom
ZSH_CUSTOM=$HOME/.zsh_damnever

# Zsh plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew pip vagrant pyenv python go golang zsh-autosuggestions kocmd)


# User configuration
export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Personal aliases
alias vim='mvim -v'

# Pyenv
export PYENV_ROOT=/usr/local/var/pyenv
eval "$(pyenv init -)"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
pyenv virtualenvwrapper

# Golang
export GOPATH=$HOME/.go:$HOME/dev/ak/Go
export PATH=$PATH:/usr/local/go/bin:$HOME/.go/bin

# Rust
# racer
# export PATH=$PATH:$HOME/.cargo/env
# export PATH=$PATH:$HOME/.cargo/bin
# rustup
# fpath+=~/.zfunc

# YCM python
export DYLD_FORCE_FLAT_NAMESPACE=1

# scp
SHTERM_AUTH_KEY=`cat ~/.ssh/id_rsa`
export SHTERM_AUTH_KEY

# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh