# Prevent accidental shell exit from pressing Ctrl-D at an empty prompt.
# Normal Ctrl-D behavior is preserved while editing input. On an empty prompt,
# exit requires IGNOREEOF repeated Ctrl-D presses within the same editing flow.
# Each qualifying press shows how many more are needed.

setopt ignore_eof

typeset -gi IGNOREEOF=3
typeset -gi __ignoreeof_remaining=0

_ignoreeof_ctrl_d() {
    if [[ -n $BUFFER ]]; then
        __ignoreeof_remaining=0
        if [[ $WIDGET == _ignoreeof_ctrl_d_vi ]]; then
            zle list-choices
        else
            zle delete-char-or-list
        fi
        return
    fi

    if [[ $LASTWIDGET != $WIDGET ]] || (( __ignoreeof_remaining <= 0 )); then
        __ignoreeof_remaining=$IGNOREEOF
    fi

    (( IGNOREEOF <= 0 )) && exit
    (( --__ignoreeof_remaining ))

    if (( __ignoreeof_remaining <= 0 )); then
        exit
    fi

    zle -M "Press Ctrl-D ${__ignoreeof_remaining} more times to exit"
}

zle -N _ignoreeof_ctrl_d
# A separate widget preserves vi completion even when viins is aliased as main.
zle -N _ignoreeof_ctrl_d_vi _ignoreeof_ctrl_d
# Startup and zsh-vi-mode can switch the active keymap after this file is loaded.
bindkey -M emacs '^D' _ignoreeof_ctrl_d
bindkey -M viins '^D' _ignoreeof_ctrl_d_vi
bindkey -M vicmd '^D' _ignoreeof_ctrl_d_vi
