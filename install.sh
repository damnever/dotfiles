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
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # for vim
    brew install wget
    brew install llvm # --with-toolchain
    brew install shellcheck
    brew install readline xz
    # brew tap macvim-dev/macvim
    # brew install --HEAD macvim-dev/macvim/macvim
    brew install neovim
    brew install gnupg pinentry-mac
    brew install zsh  # Default on macOS
    brew install ctags
    brew install fzf
    /usr/local/opt/fzf/install
    brew install pyenv pyenv-virtualenv # pyenv-virtualenvwrapper
    brew install tmux reattach-to-user-namespace
    brew install coreutils findutils gnu-getopt
    brew ln gnu-getopt --force
    # brew install yarn
    brew install node
    brew install watch
    # brew install autojump
    brew install go
    brew install cloc
    # brew install the_silver_searcher
    brew install ripgrep fd bat
    brew install tree
    brew install htop iftop
    brew install polipo
    brew install fortune
    brew install direnv
    # fonts
    brew tap homebrew/cask-fonts
    # brew install font-ibm-plex --cask
    brew install --cask font-jetbrains-mono-nerd-font # https://www.nerdfonts.com/
}

change_settings_for_mac() {
    defaults write -g KeyRepeat -int 2
    defaults write -g InitialKeyRepeat -int 9
    # defaults write -g ApplePressAndHoldEnabled -bool false
}

install_requirements_for_ubuntu() {
    set -e
    sudo apt-get update
    sudo apt-get install -y shellcheck clang-tidy
    sudo apt-get install -y vim
    sudo apt-get install -y zsh
    sudo apt-get install -y tmux
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils
    sudo apt-get install -y build-essential cmake python-dev ctags silversearcher-ag
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    ~/.fzf/install
    git clone https://github.com/yyuu/pyenv.git "$HOME/.pyenv"
    git clone https://github.com/yyuu/pyenv-virtualenvwrapper.git "$HOME/.pyenv/plugins/pyenv-virtualenvwrapper"
}


install_prerequirements() {
    if [[ "$platform" == "Darwin" ]]; then  # Mac
        change_settings_for_mac
        install_requirements_for_mac
        grep -qxF "$(which zsh)" /etc/shells || echo "$(which zsh)" | sudo tee -a /etc/shells
        chsh -s "$(which zsh)" #
        sudo chsh -s "$(which zsh)" # Install for root as well.
    elif [[ "$platform" == "Linux" ]]; then  # ubuntu for me
        install_requirements_for_ubuntu
        sudo chsh -s "$(which zsh)" ubuntu # vagrant
    fi

    GLOBAL_PYTHON=3.7.0
    # https://github.com/pyenv/pyenv/issues/1219
    pyenv install $GLOBAL_PYTHON
    pyenv global $GLOBAL_PYTHON
    pip install ipython

    # curl https://sh.rustup.rs -sSf | sh
    # rustup toolchain add nightly
    # rustup component add rust-src
    # cargo +nightly install racer

    # Tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
    # pip install  flake8 pyflakes pep8  jedi pipenv vim-vint 'python-language-server[all]'
    pip install pynvim yapf pylint
    # go install golang.org/x/tools/cmd/benchstat@latest
    # go install golang.org/x/tools/cmd/godoc@latest
    # go install golang.org/x/tools/gopls@latest
    # go install github.com/jstemmer/gotags@latest
    # yarn global add bash-language-server
    # npm install -g prettier bash-language-server

    # TODO: install lint and formaters for neovim null-ls?

    # Let's do it twice: https://github.com/wbthomason/packer.nvim
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
