# Ref: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'

# List directory contents
alias lsa='ls -lah'
alias ll='ls -lh'
