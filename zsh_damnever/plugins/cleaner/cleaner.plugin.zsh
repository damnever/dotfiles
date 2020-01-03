# Clean up dead docker containers and <none> tag images.
docker-clean() {
    docker container rm $(docker container ls -f status=exited | awk '{if (NR > 1) print $1}') 2>/dev/null
    docker rmi $(docker images | awk '{if (NR > 1 && $2 == "<none>") print $3}') 2>/dev/null
}
