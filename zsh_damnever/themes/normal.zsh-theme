# Copyright (c) 2017 XiaoChao Dong (@damnever) <dxc.wolf@gmail.com>

export VIRTUAL_ENV_DISABLE_PROMPT=1
local _ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

virtualenv_info() {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

_format() {
    local STR="$(virtualenv_info)%{$FG[081]%}${PWD/$HOME/~}%{$reset_color%} $(git_prompt_info)"
    local zero='%([BSUbfksu]|([FB]|){*})'
    local LENGTH=${#${(S%%)STR//$~zero/}}

    (( LENGTH = ${COLUMNS} - $LENGTH - 14 ))

    local SPACES=""
    for i in {0..$LENGTH}
    do
        SPACES="$SPACES "
    done

    echo "$STR $SPACES"
}

PROMPT='$(_format) $FG[248][%*]%{$reset_color%}
${_ret_status}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%}) %{$fg[green]%}✓"
