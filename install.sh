#!/bin/bash

cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
platform=$(uname)

install_xcode_command_line_tools() {
    output=$(xcode-select --install 2>&1)
    status=$?
    if [ $status != 0 ]; then
        echo "${output}"
        case "${output}" in
            *"already installed"*)
                ;;
            *)
                exit 1
                ;;
        esac
    fi
}

HOMEBREW_PREFIX=/opt/homebrew

change_mac_settings() {
    defaults write -g KeyRepeat -int 2
    defaults write -g InitialKeyRepeat -int 9
    defaults write -g ApplePressAndHoldEnabled -bool false
    # defaults -currentHost delete -globalDomain NSStatusItemSpacing
    # defaults -currentHost write -globalDomain NSStatusItemSpacing -int 8
    # defaults -currentHost delete -globalDomain NSStatusItemSelectionPadding
    # defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 8
}

install_command_line_tools() {
    # TODO: brew bundle --file=Brewfile
    brew install wget
    brew install llvm
    brew install readline xz
    brew install gnupg pinentry-mac
    # brew install ctags
    brew install fzf
    $HOMEBREW_PREFIX/opt/fzf/install
    brew install pyenv pyenv-virtualenv # pyenv-virtualenvwrapper
    brew install tmux reattach-to-user-namespace
    brew install coreutils findutils gnu-getopt
    brew ln gnu-getopt --force
    brew install node yarn  # Nodejs and..
    brew install watch
    brew install go  # Golang
    brew install swiftformat
    brew install --cask swiftformat-for-xcode
    brew install roswell # Common Lisp(sbcl) version manager
    brew install difftastic
    brew install git git-lfs
    brew install ripgrep fd bat jq
    brew install tree
    brew install htop iftop
    brew install fortune
    brew install direnv
    brew install zoxide
    brew install wireguard-tools
    # fonts
    # brew tap homebrew/cask-fonts
    # brew install font-ibm-plex --cask
    # brew install --cask font-jetbrains-mono-nerd-font # https://www.nerdfonts.com/

    go install golang.org/x/perf/cmd/benchstat@latest

    GLOBAL_PYTHON=3.11.0
    # https://github.com/pyenv/pyenv/issues/1219
    pyenv install --skip-existing -v $GLOBAL_PYTHON
    pyenv global $GLOBAL_PYTHON
    pyenv rehash
    $(pyenv which pip) install ipython httpie

    if ! command -v rustup &> /dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        rustup toolchain add nightly
        rustup component add rust-src
    fi

    # Tmux
    # git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}


sync_configuration_files() {
    echo "-> sync configuration files .."

    files=(\
        gitconfig \
        tmux.conf \
        zshrc \
        config \
    )
    for f in "${files[@]}"
    do
        target="$HOME/.$f"
        if [[ -e "$target" && ! -L "$target" ]]; then
            echo "backup: $target -> $target-backup"
            mv "$target" "${target}-backup-$(date '+%Y%m%d%H%M%S')"
        fi
        ln -vsfn "$cur_dir/$f" "$target"
    done

    mkdir -vp "$HOME/.gnupg"
    cp -rfv "$cur_dir/gnupg/" "$HOME/.gnupg"

    # shellcheck source=/dev/null
    source "$cur_dir/third_configs/install.sh"
}


setup_vim() {
    echo "-> setup vim .."
    brew install neovim

    # https://github.com/wojciech-kulik/xcodebuild.nvim
    brew install xcode-build-server
    brew install xcbeautify
    brew install ruby
    gem install xcodeproj
    # Python
    pip install pynvim yapf
    # go install github.com/client9/misspell/cmd/misspell@latest

    # Let's do it twice: https://github.com/wbthomason/packer.nvim
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}


install_fonts() {
    echo "-> install fonts .."
    unzip config/_asserts/fonts.zip -d /tmp/dotfiles-fonts
    mv "/tmp/dotfiles-fonts/fonts/Monaco Nerd Font Complete.ttf" "$HOME/Library/Fonts/"
    rm -rf /tmp/dotfiles-fonts
}

init_mac(){
    if [[ "$platform" != "Darwin" ]]; then  # Mac
        echo "unsupported platform $platform"
        exit 1
    fi

    echo "-> initialize mac .."
    install_xcode_command_line_tools

    set -e
    change_settings_for_mac
    install_fonts
    sync_configuration_files

    # https://docs.brew.sh/Installation
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brewzprofile="eval $($HOMEBREW_PREFIX/bin/brew shellenv)"
        grep -qxF "$brewzprofile" ~/.zprofile || echo "$brewzprofile" >> ~/.zprofile
        eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
    fi

    brew install zsh  # Default on macOS
    if [ "$SHELL" != "$(which zsh)" ]; then
        grep -qxF "$(which zsh)" /etc/shells || echo "$(which zsh)" | sudo tee -a /etc/shells
        chsh -s "$(which zsh)"
        sudo chsh -s "$(which zsh)" # Install for root as well.
        echo "PLEASE RESTART THE TERMINAL SESSION"
        echo "  .. and run this command again"
        exit 0
    else
        antidote-update-and-force-compinit
    fi

    install_command_line_tools
    setup_vim
}


usage() {
    echo "Usage: $0 [-i] [-t] [-c] [-v]" >&2
    echo "       -i initialize a new mac" >&2
    echo "       -t install command line tools" >&2
    echo "       -c synchronize configuration files" >&2
    echo "       -v setup vim" >&2
    echo "       -f install patched https://www.nerdfonts.com/" >&2
    exit 1
}

while getopts ":itcvf" opt; do
    case "${opt}" in
        i )
            noargs=1
            init_mac
            ;;
        t )
            noargs=1
            install_command_line_tools
            ;;
        c )
            noargs=1
            sync_configuration_files
            ;;
        v )
            noargs=1
            setup_vim
            ;;
        f )
            noargs=1
            install_fonts
            ;;
        * )
            echo "invalid option -${opt}"
            usage
            ;;
    esac
done

if [ -z "${noargs}" ]; then
    usage
else
    exec "$SHELL"
fi
