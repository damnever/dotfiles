#!/bin/bash

cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -vsfn $cur_dir/gdb-dashboard/.gdbinit $HOME/.gdbinit
