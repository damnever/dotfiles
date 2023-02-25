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

install_requirements_for_mac() {
    # NOTE: XCode is required.
    install_xcode_command_line_tools
    set -e

    # https://docs.brew.sh/Installation
    HOMEBREW_PREFIX=/opt/homebrew
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "eval $($HOMEBREW_PREFIX/bin/brew shellenv)" >> ~/.zprofile
        eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
    fi

    # TODO: brew bundle --file=Brewfile
    brew install wget
    brew install llvm
    brew install readline xz
    brew install gnupg pinentry-mac
    brew install neovim
    brew install zsh  # Default on macOS
    brew install ctags
    brew install fzf
    $HOMEBREW_PREFIX/opt/fzf/install
    brew install pyenv pyenv-virtualenv # pyenv-virtualenvwrapper
    brew install tmux reattach-to-user-namespace
    brew install coreutils findutils gnu-getopt
    brew ln gnu-getopt --force
    brew install node yarn  # Nodejs and..
    brew install watch
    brew install go  # Golang
    brew install ripgrep fd bat jq
    brew install tree
    brew install htop iftop
    brew install fortune
    brew install direnv
    # fonts
    # brew tap homebrew/cask-fonts
    # brew install font-ibm-plex --cask
    # brew install --cask font-jetbrains-mono-nerd-font # https://www.nerdfonts.com/
}

change_settings_for_mac() {
    defaults write -g KeyRepeat -int 2
    defaults write -g InitialKeyRepeat -int 9
    # defaults write -g ApplePressAndHoldEnabled -bool false
}

install_prerequirements() {
    if [[ "$platform" != "Darwin" ]]; then  # Mac
        echo "unsupported platform $platform"
        exit 1
    fi

    change_settings_for_mac
    install_requirements_for_mac

    grep -qxF "$(which zsh)" /etc/shells || echo "$(which zsh)" | sudo tee -a /etc/shells
    chsh -s "$(which zsh)" #
    sudo chsh -s "$(which zsh)" # Install for root as well.

    GLOBAL_PYTHON=3.11.0
    # https://github.com/pyenv/pyenv/issues/1219
    pyenv install $GLOBAL_PYTHON
    pyenv global $GLOBAL_PYTHON
    pip install ipython httpie

    if ! command -v rustup &> /dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        rustup toolchain add nightly
        rustup component add rust-src
    fi

    # Tmux
    # git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}


setup_config_files() {
    echo "-> setup config files .."
    files=(\
        gitconfig \
        tmux.conf \
        zshrc \
        config \
    )
    for f in "${files[@]}"
    do
        ln -vsfn "$cur_dir/$f" "$HOME/.$f"
    done
    mkdir -vp "$HOME/.gnupg"
    cp -rfv "$cur_dir/gnupg/*" "$HOME/.gnupg"
    # shellcheck source=/dev/null
    source "$cur_dir/third_configs/install.sh"

    echo "-> create dirs .."
    # mkdir -vp "$HOME/dev/ak/{C,Go,Python,Scheme,Erlang,Elixir,Rust}"
}


setup_vim() {
    echo "-> setup vim .."
    pip install pynvim yapf
    # go install golang.org/x/tools/cmd/benchstat@latest
    # go install golang.org/x/tools/cmd/godoc@latest
    # go install golang.org/x/tools/gopls@latest

    # TODO: install lint and formaters for neovim null-ls?

    # Let's do it twice: https://github.com/wbthomason/packer.nvim
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}


install_fonts() {
    unzip config/_asserts/fonts.zip -d /tmp/dotfiles-fonts
    mv "/tmp/dotfiles-fonts/fonts/Monaco Nerd Font Complete.ttf" "$HOME/Library/Fonts/"
    rm -rf /tmp/dotfiles-fonts
}


usage() {
    echo "Usage: $0 [-r] [-c] [-v]" >&2
    echo "       -r install requirements" >&2
    echo "       -c setup config files" >&2
    echo "       -v setup vim" >&2
    echo "       -f install patched https://www.nerdfonts.com/" >&2
    exit 1
}

while getopts ":rcvf" opt; do
    case "${opt}" in
        r )
            noargs=1
            install_prerequirements
            ;;
        c )
            noargs=1
            setup_config_files
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
