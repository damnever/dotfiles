addgopath() {
    cur_dir=$(pwd)
    if [[ ":$GOPATH:" != *":$cur_dir:"* ]]; then
        export GOPATH=$GOPATH:$cur_dir
    fi
    echo $GOPATH
}
