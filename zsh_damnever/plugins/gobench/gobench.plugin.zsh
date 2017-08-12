gobench() {
    cpuprof="cpu.prof"
    memprof="mem.prof"
    if [ -n "$1" ]; then
        cpuprof="$1"
    fi
    if [ -n "$2" ]; then
        memprof="$2"
    fi

    benchout=$(go test -bench=. -benchmem -cpuprofile=$cpuprof -memprofile=$memprof)
    echo $benchout
    if [ $? -eq 0 ]; then
        echo $benchout | grep Benchmark \
            | awk -v dt="$(date)" 'BEGIN {print "### " dt "\n\nmethod | N | ns/op | B/op | allocs/op \n-|-|-|-|-"}  {print $1 "|" $2 "|" $3 "|" $5 "|" $7} END {print "\n\n"}' \
            | cat >> benchmark.md
    fi
}
