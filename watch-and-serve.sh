#!/usr/bin/env bash

# Shiroa Watch and Serve Script
# This script provides live reload functionality for Shiroa projects
# since shiroa serve does not include file watching.

set -e

SHIROA="${HOME}/.cargo/bin/shiroa"
PORT="${1:-25520}"

echo "🔍 Starting Shiroa watch and serve..."
echo "📝 Watching .typ files for changes..."
echo "🌐 Server will run on http://127.0.0.1:${PORT}"
echo ""

# Initial build
echo "🔨 Initial build..."
"${SHIROA}" build

# Start serve in background
echo "🚀 Starting server..."
"${SHIROA}" serve --addr "127.0.0.1:${PORT}" >/dev/null 2>&1 &
SERVE_PID=$!

echo "✅ Server running (PID: ${SERVE_PID})"
echo ""
echo "Watching for changes... (Press Ctrl+C to stop)"
echo ""

# Cleanup function
cleanup() {
    echo ""
    echo "🛑 Stopping server..."
    kill $SERVE_PID 2>/dev/null || true
    exit 0
}

trap cleanup INT TERM

# Watch for changes using fswatch (if available) or fall back to a simple loop
if command -v fswatch >/dev/null 2>&1; then
    # Use fswatch for efficient file watching
    fswatch -o -e ".*" -i "\\.typ$" -i "\\.toml$" . | while read num; do
        echo "📝 Change detected, rebuilding..."
        "${SHIROA}" build && echo "✅ Build complete"
    done
else
    echo "⚠️  fswatch not found. Install it for better performance:"
    echo "   brew install fswatch"
    echo ""
    echo "Using fallback polling method..."
    
    # Fallback: simple polling using find
    LAST_MOD=""
    while true; do
        CURRENT_MOD=$(find . -name "*.typ" -o -name "*.toml" | xargs stat -f "%m %N" 2>/dev/null | sort -r | head -1)
        
        if [ "$CURRENT_MOD" != "$LAST_MOD" ] && [ -n "$LAST_MOD" ]; then
            echo "📝 Change detected, rebuilding..."
            "${SHIROA}" build && echo "✅ Build complete"
        fi
        
        LAST_MOD="$CURRENT_MOD"
        sleep 2
    done
fi
