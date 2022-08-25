set -gx LANG "en_US.UTF-8"
set -gx LC_ALL "en_US.UTF-8"

set -gx EDITOR nvim

set -lx platform $(uname)

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose None

    alias v nvim
    alias vim nvim

    # Autojump: https://github.com/wting/autojump
    if [ -f /usr/local/share/autojump/autojump.fish ];
        source /usr/local/share/autojump/autojump.fish
    end

    # Direnv: https://github.com/direnv/direnv
    direnv hook fish | source

    # fortune
end


# Pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Golang
set -gx GOPATH $HOME/.go
fish_add_path -a /usr/local/go/bin $HOME/.go/bin

# Rust
# rustup/racer
if command -v cargo &> /dev/null
    set -gx RUST_SRC_PATH "$(rustc --print sysroot)/lib/rustlib/src/rust/src"
    fish_add_path -p $HOME/.cargo/bin
end

# Java
if [ "$platform" = "Darwin" ]; # Mac
    set -gx JAVA_HOME $(/usr/libexec/java_home)
end

# Swift
set -gx TOOLCHAINS swift

# GPG
set -gx GPG_TTY $(tty)
ssh-add &> /dev/null
