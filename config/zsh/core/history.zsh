[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=55000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=14000

# setopt extended_history       # record timestamp of command in HISTFILE
# setopt appendhistory
setopt incappendhistory       # new history lines are added to the $HISTFILE incrementally (as soon as they are entered), rather than waiting until the shell exits
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_all_dups
# setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
