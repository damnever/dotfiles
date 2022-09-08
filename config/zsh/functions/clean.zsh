docker-clean() {
    local _query=$1
    if [ -z $_query ]; then
        docker system prune --volumes
    else
        docker rmi $(docker images | grep "$_query" | awk '{print $3}')
    fi
}
