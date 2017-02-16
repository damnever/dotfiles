#!/bin/bash

cur_dir=$(dirname $0)

platform=$(uname)
if [[ "$platform" == "Darwin" ]]; then  # Mac
    # /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # brew install zsh
    brew install ctags
    brew install the_silver_searcher
    # brew install fzf
    # /usr/local/opt/fzf/install
    # brew install pyenv
    # brew install pyenv-virtualenvwrapper
    # brew install tmux
elif [[ "$platform" == "Linux" ]]; then  # ubuntu for me
    # sudo apt-get install zsh
    sudo apt-get install build-essential cmake python-dev ctags the_silver_searcher
    # sudo apt-get install tmux
    # git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    # ~/.fzf/install
    # git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
    # git clone https://github.com/yyuu/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper
    # echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshrc
    # echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshrc
    # echo 'eval "$(pyenv init -)"' >> ~/.zshrc
fi
# chsh -s $(which zsh)
# sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

pip install pep8 pyflakes pylint -U
go get -u github.com/jstemmer/gotags


echo "-> link files .."
files=(\
    zsh_damnever \
    gitconfig \
    pypirc \
    pylintrc \
    tmux.conf \
    zshrc \
    vim \
    vimrc \
)

for f in "${files[@]}"
do
    ln -vsfn $(pwd)/$f $HOME/.$f
done


echo "-> create dirs .."
mkdir -vp $HOME/dev/ak/{C,Go,Python,Scheme}

echo "-> setup vim .."
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $HOME/.vimrc +PlugInstall! +PlugClean! +qall
export SHELL=$system_shell


exec $SHELL
