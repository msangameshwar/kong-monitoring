#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Starting all applications..."

# Array of app directories
apps=("alpha" "beta" "delta" "epsilon" "eta" "gamma" "lota" "theta" "zeta")

if [ -f "$SCRIPT_DIR/stop.sh" ]; then
    bash "$SCRIPT_DIR/stop.sh" --quiet
fi

mkdir -p logs

# Remove old PID file if it exists
if [ -f .pids ]; then
    rm .pids
fi

started_apps=()
started_pids=()

for app in "${apps[@]}"; do
    if [ -d "$app" ] && [ -f "$app/index.js" ]; then
        echo "Starting $app..."
        : > "$SCRIPT_DIR/logs/$app.log"
        # Detach each app from this shell and save the Node process ID.
        (
            cd "$app"
            nohup node index.js > "$SCRIPT_DIR/logs/$app.log" 2>&1 &
            pid=$!
            echo "$pid" >> "$SCRIPT_DIR/.pids"
            echo "$pid" > "$SCRIPT_DIR/logs/$app.pid"
            disown "$pid" 2>/dev/null || true
        )
        started_apps+=("$app")
        started_pids+=("$(cat "$SCRIPT_DIR/logs/$app.pid")")
    else
        echo "Skipping $app; app directory or index.js was not found."
    fi
done

sleep 1

failed=false
for index in "${!started_apps[@]}"; do
    app="${started_apps[$index]}"
    pid="${started_pids[$index]}"

    if ! kill -0 "$pid" 2>/dev/null; then
        echo "$app failed to start. Check logs/$app.log for details."
        if [ -s "$SCRIPT_DIR/logs/$app.log" ]; then
            tail -n 20 "$SCRIPT_DIR/logs/$app.log"
        fi
        failed=true
    fi
done

rm -f "$SCRIPT_DIR"/logs/*.pid

if [ "$failed" = true ]; then
    echo "One or more applications failed to start."
    exit 1
fi

echo "All applications are running in the background."
echo "Use ./stop.sh to stop them."
