#!/bin/bash
set -e

echo "Docker Linux Testing Script for SetUserAgent"
echo "==============================================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Please start Docker Desktop first."
    exit 1
fi

# Check if XQuartz is available (for X11 forwarding)
if ! command -v xhost > /dev/null 2>&1; then
    echo "XQuartz is not installed or not in PATH."
    echo "   Please install XQuartz first:"
    echo "   brew install --cask xquartz"
    echo "   Then log out and log back in (or restart your Mac)"
    exit 1
fi

# Build the Docker image
echo ""
echo "Building Docker image for Linux testing..."
docker build -f Docker/useragent/Dockerfile -t webview-linux-test .

if [ $? -ne 0 ]; then
    echo "Docker build failed"
    exit 1
fi

echo "Docker image built successfully"

# Set up X11 forwarding for macOS
echo ""
echo "Setting up X11 forwarding..."

# Check if XQuartz is running
if ! pgrep -x "X11" > /dev/null && ! pgrep -x "Xquartz" > /dev/null; then
    echo "XQuartz is not running."
    echo "   Please start XQuartz manually"
    echo "   Then run this script again."
    echo ""
    echo "   Alternatively, you can start it automatically:"
    open -a XQuartz
    echo "   Waiting 5 seconds for XQuartz to start..."
    sleep 5
fi

# Allow connections from localhost
xhost +localhost > /dev/null 2>&1 || true

echo "X11 forwarding configured"

# Run the container with GUI support
echo ""
echo "Running Linux container with GUI support..."
echo "   This will:"
echo "   - Start a Linux container with WebKit2GTK"
echo "   - Forward the display to your macOS screen via XQuartz"
echo "   - Run the SetUserAgent demo"
echo ""

docker run --rm \
    -e DISPLAY=host.docker.internal:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    webview-linux-test

echo ""
echo "Linux testing completed!"
echo ""
echo "If you saw a window with the user agent detection page, the test was successful!"
echo ""
echo "💡 Tips:"
echo "   - Make sure XQuartz is running before running this script"
echo "   - The window should show Chrome user agent instead of Linux WebKit"
echo "   - If no window appeared, check XQuartz settings and firewall"
