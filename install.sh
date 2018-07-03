#!/bin/bash

cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
platform=$(uname)


install_requirements_for_mac() {
    # for vim
    brew install --with-toolchain llvm
    brew install shellcheck
    brew install readline xz
    brew install macvim --HEAD --with-cscope --with-lua --with-luajit --with-python --with-override-system-vim
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install gnupg pnupg2 gpg-agent pinentry-mac # for gpg
    brew install zsh
    brew install ctags
    brew install the_silver_searcher
    brew install fzf
    /usr/local/opt/fzf/install
    brew install pyenv
    brew install pyenv-virtualenvwrapper
    brew install tmux
    brew install coreutils findutils gnu-getopt
    brew ln gnu-getopt --force
    brew install yarn
    brew install watch
    brew install autojump
}

change_settings_for_mac() {
    # Ref: https://github.com/mathiasbynens/dotfiles/issues/687
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 10
}

install_requirements_for_ubuntu() {
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
        sudo chsh -s "$(which zsh)"
    elif [[ "$platform" == "Linux" ]]; then  # ubuntu for me
        install_requirements_for_ubuntu
        sudo chsh -s "$(which zsh)" ubuntu # vagrant
    fi
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}


setup_config_files() {
    echo "-> setup config files .."
    files=(\
        zsh_damnever \
        gitconfig \
        pypirc \
        pylintrc \
        tmux.conf \
        zshrc \
        vim \
        vimrc \
        pip \
        config \
    )
    for f in "${files[@]}"
    do
        ln -vsfn "$cur_dir/$f" "$HOME/.$f"
    done
    mkdir -vp "$HOME/.gnupg"
    cp -rfv "$cur_dir/gnupg/*" "$HOME/.gnupg"
    # shellcheck source=/dev/null
    source $cur_dir/third_configs/install.sh

    echo "-> create dirs .."
    # mkdir -vp "$HOME/dev/ak/{C,Go,Python,Scheme,Erlang,Elixir,Rust}"
}


setup_vim() {
    echo "-> setup vim .."
    pip install flake8 pyflakes pep8 pylint jedi pipenv -U
    go get -u github.com/jstemmer/gotags
    go get -u github.com/nsf/gocode
    go get -u github.com/zmb3/gogetdoc
    go get -u golang.org/x/tools/cmd/guru
    go get -u github.com/alecthomas/gometalinter
    gometalinter --install

    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    system_shell=$SHELL
    export SHELL="/bin/sh"
    vim -u "$HOME/.vimrc" +PlugInstall! +PlugClean! +qall
    export SHELL=$system_shell
}


usage() {
    echo "Usage: $0 [-r] [-c] [-v]" >&2
    echo "       -r install requirements" >&2
    echo "       -c setup config files" >&2
    echo "       -v setup vim" >&2
    exit 1
}


while getopts ":rcv" opt; do
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
