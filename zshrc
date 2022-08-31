# See the last line.
# zmodload zsh/zprof

# Plugin manager.
# This must be done before running compinit.
# NOTE: should delete ~/.cache/zsh/compdump to make autocompletion plugin work.
# Ref: https://getantidote.github.io/#:~:text=ultra%20high%20performance%20install
if [ ! -d ~/.local/share/antidote ]; then mkdir -p ~/.local/share/antidote; fi
antidotepath=${ZDOTDIR:-~/.local/share/antidote}/.antidote
if ! [[ -e $antidotepath ]]; then
  git clone https://github.com/mattmc3/antidote.git $antidotepath
fi
antidotebundlefile=~/.config/zsh/antidote_zsh_plugins.txt
zstyle ':antidote:bundle' file $antidotebundlefile
antidotestaticfile=~/.local/share/antidote/zsh_plugins.zsh
zstyle ':antidote:static' file $antidotestaticfile
zstyle ':antidote:bundle' use-friendly-names 'yes'
# source antidote and load plugins from `${ZDOTDIR:-~}/.zsh_plugins.txt`
source $antidotepath/antidote.zsh
antidote load


# We will run some scripts to setup things, including compinit.
for setup in ~/.config/zsh/core/*; do
    source $setup
done

# My custom theme.
source ~/.config/zsh/themes/damnever.zsh-theme

# Functions
for function in ~/.config/zsh/functions/*; do
  source $function
done


# Binding keys
# As an addition to https://github.com/jlevy/the-art-of-command-line#everyday-use
bindkey -e  # https://stackoverflow.com/questions/23128353/zsh-shortcut-ctrl-a-not-working
bindkey '^j' backward-word
bindkey '^k' forward-word


export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"
if [[ "$OSTYPE" == "darwin"* ]]; then  # Mac
    export PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"
    export MANPATH="$MANPATH:/usr/local/opt/coreutils/libexec/gnuman"
    export MANPATH="$MANPATH:/usr/local/opt/findutils/libexec/gnuman"
    export PATH="$PATH:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/llvm/bin"
fi

# Manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR='nvim'

# Aliases
alias v='nvim'
alias vim='nvim'
alias ll='ls -lh'


# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -  --path --no-rehash zsh)"
# eval "$(pyenv virtualenv-init -)" # Too slow and maybe useless


# Golang
export GOPATH=$HOME/.go
export PATH=$PATH:/usr/local/go/bin:$HOME/.go/bin

# Rust
source $HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin

# Java
if [[ "$OSTYPE" == "darwin"* ]]; then  # Mac
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

# Swift
export TOOLCHAINS=swift

# Fzf: https://github.com/junegunn/fzf
# $(brew --prefix)/opt/fzf/install --no-bash --no-fish
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Direnv: https://github.com/direnv/direnv
eval "$(direnv hook zsh)"

# GPG
export GPG_TTY=$(tty)
ssh-add &> /dev/null

# Print something after each load..
# fortune

# See the first line.
# zprof
