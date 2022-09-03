#!/bin/bash

cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
curl -Lo "${cur_dir}/words_alpha.txt" \
    https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt
