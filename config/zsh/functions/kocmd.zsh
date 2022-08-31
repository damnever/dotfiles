# Kill command(program) by name, eg. kocmd python test.py
platform=$(uname)
if [[ "$platform" == "Darwin" ]]; then  # Mac
    alias psaux='ps aux'
elif [[ "$platform" == "Linux" ]]; then
    alias psaux='ps -aux'
fi

kocmd() {
    if [ $# -eq 0 ]; then
        echo "no enough args"
        return
    fi

    name=""
    index=1
    for arg in "$*"; do
        if [ 1 -eq $index ]; then
            name+="$arg"
        else
            name+=" $arg"
        fi
        ((++index))
    done
    kill -9 $(psaux | grep "$name" | grep -v "grep" | awk '{print $2}')
}
