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
# ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Custom folder than $ZSH/custom
ZSH_CUSTOM=$HOME/.zsh_damnever
fpath+=~/.zfunc

# Zsh plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
brew
pip
vagrant
docker kubectl
pyenv python
golang
cargo
zsh-autosuggestions
autojump
# Custom plugins
kocmd
gotools
proxy
colors
cleaner)

# Binding keys
# As an addition to https://github.com/jlevy/the-art-of-command-line#everyday-use
bindkey '^j' backward-word
bindkey '^k' forward-word


# User configuration
platform=$(uname)

export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"
if [[ "$platform" == "Darwin" ]]; then  # Mac
    export PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"
    export MANPATH="$MANPATH:/usr/local/opt/coreutils/libexec/gnuman"
    export MANPATH="$MANPATH:/usr/local/opt/findutils/libexec/gnuman"
    export PATH="$PATH:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/llvm/bin"
fi

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
if [[ "$platform" == "Darwin" ]]; then  # Mac
    alias vim='nvim'  # 'mvim -v'
fi


# autojump
if [[ "$platform" == "Darwin" ]]; then  # Mac
    [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
fi


# Pyenv
if [[ "$platform" == "Darwin" ]]; then  # Mac
    export PYENV_ROOT=/usr/local/var/pyenv
else  # Linux
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
fi
eval "$(pyenv init -)"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
# pyenv virtualenvwrapper
# Pipenv
eval "$(pipenv --completion)"

# Golang
export GOPATH=$HOME/.go:$HOME/dev/ak/Go
export PATH=$PATH:/usr/local/go/bin:$HOME/.go/bin:$HOME/dev/ak/Go/bin
# for go-torch
export PATH=$PATH:$HOME/.bin/FlameGraph

# Rust
# rustup/racer
source $HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Java
if [[ "$platform" == "Darwin" ]]; then  # Mac
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

# Swift
export TOOLCHAINS=swift

# scp
SHTERM_AUTH_KEY=`cat ~/.ssh/id_rsa`
export SHTERM_AUTH_KEY

# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# GPG
export GPG_TTY=$(tty)
ssh-add &> /dev/null

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Print something after each load..
fortune
