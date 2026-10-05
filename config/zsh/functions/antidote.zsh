_antidote_rebuild_cache() (
    emulate -L zsh
    unsetopt bgnice
    local bundle_file=$1 static_file=$2 completion_cache=$3
    local candidate line antidote_home

    [[ -r $bundle_file ]] || { print -ru2 -- "zsh-repair: plugin list missing: $bundle_file"; return 1; }
    mkdir -p -- "${static_file:h}" || return 1
    candidate=$(mktemp "${static_file}.repair.XXXXXX") || return 1
    trap 'rm -f -- "$candidate"' EXIT
    trap 'exit 130' INT
    trap 'exit 143' HUP TERM

    # Generate separately so a later success cannot hide an earlier failure.
    while IFS= read -r line || [[ -n $line ]]; do
        line=${line%%\#*}
        [[ -z ${line//[[:space:]]/} ]] && continue
        if ! antidote bundle "$line" >> "$candidate"; then
            print -ru2 -- 'zsh-repair: plugin generation failed; existing cache retained'
            return 1
        fi
    done < "$bundle_file"
    if [[ ! -s $candidate ]] || ! command zsh -dfn "$candidate"; then
        print -ru2 -- 'zsh-repair: generated cache is empty or invalid; existing cache retained'
        return 1
    fi

    # A newer compiled file can override the repaired text file.
    rm -f -- "${static_file}.zwc" || return 1
    mv -f -- "$candidate" "$static_file" || return 1
    rm -f -- "$completion_cache/compdump" "$completion_cache/compdump.zwc" || return 1
    antidote_home=$(antidote home) || return 1
    mkdir -p -- "$antidote_home" && touch "$antidote_home/.antidote.load"
)

zsh-repair() {
    _antidote_rebuild_cache "$antidotebundlefile" "$antidotestaticfile" "$ZSH_CACHE" || return 1
    if [[ -o interactive ]]; then
        print -r -- 'zsh-repair: plugin cache repaired; reloading shell'
        exec zsh
    else
        print -r -- 'zsh-repair: repair complete. Run exec zsh to reload this terminal.'
    fi
}

antidote-update-and-force-compinit() {
    antidote update && zsh-repair
}
