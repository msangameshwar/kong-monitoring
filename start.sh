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

for app in "${apps[@]}"; do
    if [ -d "$app" ] && [ -f "$app/index.js" ]; then
        echo "Starting $app..."
        # Detach each app from this shell and save the Node process ID.
        (
            cd "$app"
            nohup node index.js > "$SCRIPT_DIR/logs/$app.log" 2>&1 &
            pid=$!
            echo "$pid" >> "$SCRIPT_DIR/.pids"
            disown "$pid" 2>/dev/null || true
        )
    else
        echo "Skipping $app; app directory or index.js was not found."
    fi
done

echo "All applications are running in the background."
echo "Use ./stop.sh to stop them."
