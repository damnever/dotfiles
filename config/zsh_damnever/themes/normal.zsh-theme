# Copyright (c) 2017 XiaoChao Dong (@damnever) <dxc.wolf@gmail.com>

export VIRTUAL_ENV_DISABLE_PROMPT=1
local _ret_status="%(?:%{$fg_bold[green]%}❯:%{$fg_bold[red]%}❯)"  # ● • ⦿ ➢  ➤  ‣ ❯ ➜

virtualenv_info() {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

_format_with_time() { # deprecated
    local STR="$(virtualenv_info)%{$fg[081]%}${PWD/$HOME/~}%{$reset_color%} $(git_prompt_info)"
    local origin_lang=${LANG} origin_lcall=${LC_ALL} # Get bytes other than chars
    LANG=C LC_ALL=C
    local zero='%([BSUbfksu]|([FK]|){*})'
    local LENGTH=${#${(S%%)STR//$~zero/}}
    LANG=${origin_lang} LC_ALL=${origin_lcall} # Restore

    (( LENGTH = ${COLUMNS} - $LENGTH - 18 ))

    local SPACES=""
    for i in {0..$LENGTH}
    do
        SPACES="$SPACES "
    done

    echo "$STR $SPACES"
}

_format() {
    local STR="$(virtualenv_info)$FG[059]%*%{$reset_color%} %{$FG[117]%}${PWD/$HOME/~}%{$reset_color%} $(git_prompt_info)"
    echo "$STR"
}

PROMPT='$(_format)%{$reset_color%}
${_ret_status}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[123]%}git:(%{$FG[174]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[123]%}) %{$fg_bold[yellow]%}✗"  # ✘
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[123]%}) %{$fg_bold[green]%}✓"  # ✔︎
