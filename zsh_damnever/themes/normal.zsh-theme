local _ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

_PATH="${PWD/$HOME/~}"

get_space() {
    local STR="$_PATH$(git_prompt_info)"
    local zero='%([BSUbfksu]|([FB]|){*})'
    local LENGTH=${#${(S%%)STR//$~zero/}}
    (( LENGTH = ${COLUMNS} - $LENGTH - 16 ))
    local SPACES=""
    for i in {0..$LENGTH}
    do
        SPACES="$SPACES "
    done
    echo $SPACES
}

PROMPT=' %{$FG[081]%}$_PATH%{$reset_color%} $(git_prompt_info) $(get_space) $FG[248][%*]%{$reset_color%}
${_ret_status}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%}) %{$fg[green]%}✓"
