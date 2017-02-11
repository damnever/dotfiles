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



platform=$(uname)
if [[ "$platform" == "Darwin" ]]; then  # Mac
    brew install ctags
    brew install the_silver_searcher
    brew install fzf
    /usr/local/opt/fzf/install
    brew install pyenv
    brew install pyenv-virtualenvwrapper
    brew install tmux
elif [[ "$platform" == "Linux" ]]; then  # ubuntu for me
    sudo apt-get install build-essential cmake python-dev ctags the_silver_searcher tmux
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    ~/.fzf/install
    git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
    git clone https://github.com/yyuu/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
fi
pip install pep8 pyflakes pylint -U
go get -u github.com/jstemmer/gotags

echo "-> setup vim .."

curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

system_shell=$SHELL
export SHELL="/bin/sh"
# vim test.go is a trick for "Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }"
vim test.go -u $HOME/.vimrc +PlugInstall! +PlugClean! +qall
export SHELL=$system_shell


exec $SHELL
