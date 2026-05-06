#!/bin/bash

if [ -f .pids ]; then
    echo "Stopping all applications..."
    while read -r pid; do
        if kill -0 "$pid" 2>/dev/null; then
            kill "$pid"
            echo "Stopped process $pid"
        fi
    done < .pids
    rm .pids
    echo "All applications stopped."
else
    echo "No .pids file found. Are the applications running?"
fi
