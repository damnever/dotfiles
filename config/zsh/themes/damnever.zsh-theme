# Copyright (c) 2022 XiaoChao Dong (@damnever) <the.xcdong@gmail.com>
#
export VIRTUAL_ENV_DISABLE_PROMPT=1

typeset -g THEME_LAST_ZSH_CMD_EXIT_CODE=0 # Cache exit status.

_theme_precmd() {
    THEME_LAST_ZSH_CMD_EXIT_CODE=$?
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _theme_precmd

_indicator_before_input() {
    # Adjust the color based on the previous status and update the symbol according to the ZVM_MODE.
    local _symbol _color

    # ● • ⦿ ➢  ➤  ‣ ❯ ➜  ❮ ❚
    if [[ -n "$ZVM_MODE" ]] && [[ "$ZVM_MODE" != "$ZVM_MODE_INSERT" ]]; then
        _symbol="❚"
    else
        _symbol="❯"
    fi

    if (( THEME_LAST_ZSH_CMD_EXIT_CODE == 0 )); then
        _color="%{$fg_bold[green]%}"
    else
        _color="%{$fg_bold[red]%}"
    fi

    echo "${_color}${_symbol}%{$reset_color%}"
}

_virtualenv_info() {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

_git_info() {
    local ref
    ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return  # no git repo.
        ref=$(git rev-parse --short HEAD 2> /dev/null) || return
    fi
    local _git_branch_name=${ref#refs/heads/}

    if [[ -n $_git_branch_name ]]; then
        local _git_branch_info=" %F{123}git:(%F{174}$_git_branch_name%F{123})%{$reset_color%}"
        local _git_is_dirty=$(! git diff-index --cached --quiet HEAD -- >/dev/null 2>&1 \
            || ! git diff --no-ext-diff --quiet --exit-code >/dev/null 2>&1 \
            || git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>&1 \
            && echo "yes")
        if [[ -n "$_git_is_dirty" ]]; then
            echo "$_git_branch_info %{$fg_bold[yellow]%}✗%{$reset_color%}" # ✘
        else
            echo "$_git_branch_info %{$fg_bold[green]%}✓%{$reset_color%}" # ✔︎
        fi
    fi
}

_current_time() {
    echo "%F{059}%*%{$reset_color%}"
}

_pwd() {
    echo "%F{117}%~%f"
}


PROMPT='$(_virtualenv_info)$(_current_time) $(_pwd)$(_git_info)
$(_indicator_before_input) '