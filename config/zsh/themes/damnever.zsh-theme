# Copyright (c) 2022 XiaoChao Dong (@damnever) <the.xcdong@gmail.com>
#
export VIRTUAL_ENV_DISABLE_PROMPT=1
local _ret_status="%(?:%{$fg_bold[green]%}❯:%{$fg_bold[red]%}❯)%{$reset_color%}"  # ● • ⦿ ➢  ➤  ‣ ❯ ➜

_virtualenv_info() {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

_git_info() {
    local _git_branch_name=$(command git symbolic-ref --short HEAD 2>/dev/null || git name-rev --name-only HEAD 2>/dev/null)
    if [[ -n $_git_branch_name ]]; then
        local _git_branch_info=" %F{123}git:(%F{174}$_git_branch_name%F{123})%{$reset_color%}"
        local _git_is_dirty=$(! command git diff-index --cached --quiet HEAD -- >/dev/null 2>&1 \
            || ! command git diff --no-ext-diff --quiet --exit-code >/dev/null 2>&1 \
            || command git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>&1 \
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
${_ret_status} '
