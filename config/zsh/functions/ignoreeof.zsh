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
        zle delete-char-or-list
        return
    fi

    if [[ $LASTWIDGET != _ignoreeof_ctrl_d ]]; then
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
bindkey '^D' _ignoreeof_ctrl_d
