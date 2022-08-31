# NOTE: use fish_add_path --path to avoid: https://github.com/fish-shell/fish-shell/issues/6641

set -gx LANG "en_US.UTF-8"
set -gx LC_ALL "en_US.UTF-8"

set -gx EDITOR nvim

set -lx platform $(uname)

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose None

    alias v nvim
    alias vim nvim
    alias unset 'set --global --erase'

    # Autojump: https://github.com/wting/autojump
    if [ -f /usr/local/share/autojump/autojump.fish ];
        source /usr/local/share/autojump/autojump.fish
    end

    # Direnv: https://github.com/direnv/direnv
    direnv hook fish | source

    # fortune
end


# Pyenv
set -gx PYENV_ROOT $HOME/.pyenv
fish_add_path --path -a $PYENV_ROOT/bin
pyenv init - --path --no-rehash fish | source
# pyenv virtualenv-init - fish | source  # Too slow and maybe useless

# Golang
set -gx GOPATH $HOME/.go
fish_add_path --path -a /usr/local/go/bin $HOME/.go/bin

# Rust
fish_add_path --path -p $HOME/.cargo/bin

# Java
if [ "$platform" = "Darwin" ]; # Mac
    set -gx JAVA_HOME $(/usr/libexec/java_home)
end

# Swift
set -gx TOOLCHAINS swift

# GPG
set -gx GPG_TTY $(tty)
ssh-add &> /dev/null
