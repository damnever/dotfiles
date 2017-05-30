# Copyright (c) 2017 XiaoChao Dong (@damnever) <dxc.wolf@gmail.com>

local _ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

_format() {
    local _PATH="${PWD/$HOME/~}"
    local _GIT="$(git_prompt_info)"
    local STR="${_PATH}${_GIT}"
    local zero='%([BSUbfksu]|([FB]|){*})'
    local LENGTH=${#${(S%%)STR//$~zero/}}

    (( LENGTH = ${COLUMNS} - $LENGTH - 15 ))
    local SPACES=""
    for i in {0..$LENGTH}
    do
        SPACES="$SPACES "
    done

    echo "%{$FG[081]%}${_PATH}%{$reset_color%} ${_GIT} $SPACES"
}

PROMPT='$(_format) $FG[248][%*]%{$reset_color%}
${_ret_status}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%}) %{$fg[green]%}✓"
