#!/bin/bash

PID_FILE="server.pid"

if [ ! -f "$PID_FILE" ]; then
    echo "⚠️ No PID file found. Is the app running?"
    exit 1
fi

PID=$(cat "$PID_FILE")

if kill -9 "$PID" > /dev/null 2>&1; then
    echo "🛑 App stopped (PID: $PID)"
    rm -f "$PID_FILE"
else
    echo "❌ Failed to stop app. It may not be running."
fi
