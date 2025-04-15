#!/bin/bash

# Configuration
APP_COMMAND="python app.py"
LOG_DIR="./logs"
STDOUT_LOG="$LOG_DIR/server.out"
STDERR_LOG="$LOG_DIR/server.err"
PID_FILE="server.pid"
LOGROTATE_CONFIG="llm_logs.logrotate"
LOGROTATE_DEST="/etc/logrotate.d/llm_logs"

# Ensure logs directory exists
mkdir -p "$LOG_DIR"

# Check if already running
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "🚫 Server already running (PID: $PID)"
        exit 1
    else
        echo "⚠️ PID file exists but process not found. Cleaning up."
        rm -f "$PID_FILE"
    fi
fi

# Register logrotate config (run once)
if [ -f "$LOGROTATE_CONFIG" ]; then
    if [ "$EUID" -ne 0 ]; then
        echo "⚠️ Skipping logrotate config (needs sudo). Run manually:"
        echo "    sudo cp $LOGROTATE_CONFIG $LOGROTATE_DEST"
    elif [ ! -f "$LOGROTATE_DEST" ]; then
        echo "📦 Setting up logrotate config..."
        sudo cp "$LOGROTATE_CONFIG" "$LOGROTATE_DEST"
    fi
fi

# Start the app with nohup and redirect output
echo "🚀 Starting LLM app..."
nohup $APP_COMMAND > "$STDOUT_LOG" 2> "$STDERR_LOG" &

# Save the PID
echo $! > "$PID_FILE"

echo "✅ App started with PID $(cat $PID_FILE)"
echo "📜 Logs:"
echo "   STDOUT: $STDOUT_LOG"
echo "   STDERR: $STDERR_LOG"
