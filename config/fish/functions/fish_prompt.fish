function fish_prompt
    set --function exit_code $status  # save previous exit code

    set --function _virtualenv_info $([ $VIRTUAL_ENV ] && echo '('$(basename $VIRTUAL_ENV)') ')

    set --function _git_info ""
    set --function _git_branch_name $(
        command git symbolic-ref --short HEAD 2>/dev/null;
                or command git name-rev --name-only HEAD 2>/dev/null
    )
    if test -n "$_git_branch_name"
        set --local _git_branch_info " $(set_color 87FFFF)git:($(set_color normal)$(set_color D78787)$_git_branch_name$(set_color normal)$(set_color 87FFFF))$(set_color normal)"
        # git status --porcelain 2> /dev/null | tail -n 1
        set --function _is_git_dirty $(
            not command git diff-index --cached --quiet HEAD -- >/dev/null 2>&1
            or not command git diff --no-ext-diff --quiet --exit-code >/dev/null 2>&1
            or command git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>&1
            and echo "yes"
        )
        if test -n "$_is_git_dirty"
            set --function _git_info "$_git_branch_info $(set_color yellow)✗$(set_color normal)"
        else
            set --function _git_info "$_git_branch_info $(set_color green)✓$(set_color normal)"
        end
    end

    set --function _current_time "$(set_color 5F5F5F)$(date '+%H:%M:%S')$(set_color normal)"

    set --function _current_path "$(set_color 87D7FF)$(prompt_pwd --dir-length=16 --full-length-dirs=1)$(set_color normal)"

    if not test $exit_code -eq 0  # ● • ⦿ ➢  ➤  ‣ ❯ ➜
        set --function _ret_status "$(set_color --bold red)❯$(set_color normal)"
    else
        set --function _ret_status "$(set_color --bold green)❯$(set_color normal)"
    end

    echo "$_virtualenv_info$_current_time $_current_path$_git_info"
    echo "$_ret_status "
end
