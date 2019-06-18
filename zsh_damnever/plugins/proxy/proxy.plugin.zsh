# FIXME(damnever): race condition..
PROXY_PORT=8123
PID_FILE=/tmp/proxy-polipo-$PROXY_PORT.pid
PROXY_ADDR=http://127.0.0.1:$PROXY_PORT

proxy-set() {
    if [ -f $PID_FILE ] && kill -0 $(cat $PID_FILE); then
        echo "Proxy is already running.."
    else
        socks_parent_proxy=127.0.0.1:1080
        if [ $# -eq 1 ]; then
            socks_parent_proxy=$1
        fi
        polipo socksProxyType=socks5 \
            socksParentProxy=$socks_parent_proxy \
            proxyPort=$PROXY_PORT > /dev/null 2>&1 &
        echo $! > $PID_FILE
    fi

    export http_proxy=$PROXY_ADDR
    export https_proxy=$PROXY_ADDR
    echo "polipo: $PROXY_ADDR <-> socks://$socks_parent_proxy"
}

proxy-unset() {
    unset http_proxy
    unset https_proxy
    if [ -f $PID_FILE ]; then
        kill $(cat $PID_FILE)
        rm $PID_FILE
    fi
}
