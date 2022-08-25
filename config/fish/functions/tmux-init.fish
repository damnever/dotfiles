function tmux-init
    if test -n "$TMUX"
        return
    end
    set --local sessions d a m n e v r
    for s in $sessions
        echo "create tmux session: $s"
        tmux new-session -d -s $s
    end
    echo ""
    echo "You can attach to a tmux session like this: tmux a -t d"
end
