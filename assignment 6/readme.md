# Automation & Scripting ( 🧠 LLM App Server Management Toolkit )

A DevOps-ready toolkit to reliably launch, manage, and monitor a Python-based Large Language Model (LLM) application on any Linux server.

This toolkit includes:

- Background service management using nohup
- PID tracking for safe and idempotent shutdowns
- Structured stdout and stderr logging
- Automated log rotation via logrotate

* * *

## ✨ Features

- start\_llm\_server.sh: Starts the LLM app in the background with proper logging
- stop\_llm\_server.sh: Gracefully stops the app using its stored PID
- llm\_logs.logrotate: Predefined logrotate config to manage log size and retention
- log\_analyze.py: Basic Python script to inspect logs and extract errors/warnings

* * *

## 🛠️ Requirements

- Linux or Unix-like OS
- Bash shell
- Python 3.x
- logrotate installed (usually pre-installed on most distros)

* * *

## 🚀 Getting Started

1. Clone the repository and ensure your app.py (or equivalent Python entrypoint) is in place.
2. Make the scripts executable:
   ```bash
     chmod +x start_llm_server.sh stop_llm_server.sh
   ```

3.Start the server:
```bash
./start_llm_server.sh
```
4.Stop the server:

```bash
./stop_llm_server.sh
```
## 📦 Logging & Monitoring

Log output is redirected to the ./logs directory:

- logs/server.out → Standard output
- logs/server.err → Standard error

These logs are monitored and rotated using logrotate to prevent disk exhaustion.

🔄 Log Rotation Setup
Copy the provided logrotate config to your system:

```bash
sudo cp llm_logs.logrotate /etc/logrotate.d/llm_logs
```

```bash
sudo logrotate -f /etc/logrotate.d/llm_logs
```
Config behavior:

  Rotates logs daily

  Retains last 7 log files

  Compresses old logs using gzip

  Uses copytruncate to avoid restarting the running server

🔐 PID Management
    Process ID is saved in server.pid
  
  Prevents accidental multiple instance launches

  Ensures safe shutdowns and log cleanup
  
