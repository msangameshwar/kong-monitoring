#!/bin/bash

echo "Starting all applications..."

# Array of app directories
apps=("alpha" "beta" "delta" "epsilon" "eta" "gamma" "lota" "theta" "zeta")

# Remove old PID file if it exists
if [ -f .pids ]; then
    rm .pids
fi

for app in "${apps[@]}"; do
    if [ -d "$app" ]; then
        echo "Starting $app..."
        # Start each app in the background
        (cd "$app" && node index.js) &
        # Save the process ID to .pids file
        echo $! >> .pids
    fi
done

echo "All applications are running in the background."
echo "Use ./stop.sh to stop them."
