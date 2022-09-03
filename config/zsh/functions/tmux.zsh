tmux-init() {
    if [ -n "$TMUX" ]; then
        return
    fi
    sessions=(d a m n e v r)
    for s in $sessions; do
        echo "create tmux session: $s"
        tmux new-session -d -s $s
    done
    echo ""
    echo "Attach to a tmux session like this: tmux a -t d"
}
