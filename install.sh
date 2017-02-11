#!/bin/bash

cur_dir=$(dirname $0)

echo "-> link files .."
files=(\
    bitbar_plugins \
    zsh_damnever \
    gitconfig \
    pypirc \
    tmux.conf \
    zshrc \
    vimrc \
)

for f in "${files[@]}"
do
    ln -vsfn $(pwd)/$f $HOME/.$f
done


echo "-> create dirs .."
mkdir -vp $HOME/dev/ak/{C,Go,Python,Scheme}


echo "-> setup vim .."

platform=$(uname)
if [[ "$platform" == "Darwin" ]]; then  # Mac
    brew install ctags
    brew install the_silver_searcher
    brew install fzf
    /usr/local/opt/fzf/install
elif [[ "$platform" == "Linux" ]]; then  # ubuntu for me
    sudo apt-get install build-essential cmake python-dev ctags the_silver_searcher
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi
pip install pep8 pyflakes pylint -U
go get -u github.com/jstemmer/gotags

curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

system_shell=$SHELL
export SHELL="/bin/sh"
# vim test.go is a trick for "Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }"
vim test.go -u $HOME/.vimrc +PlugInstall! +PlugClean! +qall
export SHELL=$system_shell


exec $SHELL
