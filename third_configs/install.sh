#!/bin/bash

cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cp -vf $cur_dir/gdb-dashboard/.gdbinit $HOME/.gdbinit
# For the macOS High Sierra..
if [[ $(uname) == "Darwin" ]]; then  # Mac
    fixstr="set startup-with-shell off"
    # if [[ $(tail -n 1 $HOME/.gdbinit) != $fixstr ]]; then
    echo $fixstr >> $HOME/.gdbinit
fi
