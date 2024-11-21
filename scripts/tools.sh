# tools.sh

# Updated: <2024-11-20 17:44:42 david.hisel>

function cmdexist {
    command -v "$1" > /dev/null 2>&1 && return 0 || return 1
}
function checktool {
    cmdexist "$1" && return 0 || echo "WARN: tool not found: $1" && return 1
}

export CURL="${CURL:-curl}"
checktool "$CURL"

export JQ="${JQ:-./bin/gojq}"
checktool "$JQ"




