# Check if the port number is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <port>"
    return 2>/dev/null
    exit 1
fi

# Get the process ID (PID) running on the specified port
PID=$(lsof -t -i :$1)

# Check if any process is using the specified port
if [ -z "$PID" ]; then
    echo "No process found running on port $1"
    return 2>/dev/null
    exit 1
fi

# Kill the process running on the specified port
kill $PID

echo "Process $PID running on port $1 has been terminated"
