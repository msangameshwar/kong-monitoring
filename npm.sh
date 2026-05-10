#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Installing npm dependencies for all applications..."

apps=("alpha" "beta" "delta" "epsilon" "eta" "gamma" "lota" "theta" "zeta")

for app in "${apps[@]}"; do
    if [ -d "$app" ] && [ -f "$app/package.json" ]; then
        echo "Installing dependencies in $app..."
        (
            cd "$app"
            npm i
        )
    else
        echo "Skipping $app; app directory or package.json was not found."
    fi
done

echo "Finished installing npm dependencies for all applications."
