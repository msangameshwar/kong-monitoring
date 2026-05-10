#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

quiet=false
if [ "${1:-}" = "--quiet" ]; then
    quiet=true
fi

ports=(3001 3002 3003 3004 3005 3006 3007 3008 3009)
stopped=false

stop_pid() {
    local pid="$1"

    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
        kill "$pid" 2>/dev/null || true
        echo "Stopped process $pid"
        stopped=true
    fi
}

if [ -f .pids ]; then
    echo "Stopping all applications..."
    while read -r pid; do
        if [ -n "$pid" ]; then
            stop_pid "$pid"
        fi
    done < .pids
    rm .pids
else
    if [ "$quiet" = false ]; then
        echo "No .pids file found. Checking application ports..."
    fi
fi

if command -v lsof >/dev/null 2>&1; then
    for port in "${ports[@]}"; do
        while read -r pid; do
            stop_pid "$pid"
        done < <(lsof -tiTCP:"$port" -sTCP:LISTEN 2>/dev/null || true)
    done
else
    echo "lsof is not installed; skipped port-based cleanup."
fi

if [ "$stopped" = true ]; then
    echo "All applications stopped."
elif [ "$quiet" = false ]; then
    echo "No running applications were found."
fi
