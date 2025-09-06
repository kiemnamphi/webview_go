#!/bin/bash
set -e

echo "Building SetUserAgent example for Linux..."

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check Go installation
if ! command_exists go; then
    echo "Go is not installed. Please install Go first:"
    echo "   sudo apt install golang-go    # Ubuntu/Debian"
    echo "   sudo yum install golang       # CentOS/RHEL"
    exit 1
fi

# Check required development packages
echo "Checking system dependencies..."

if ! pkg-config --exists webkit2gtk-4.0; then
    echo "WebKit2GTK development packages are missing."
    echo "   Please install the required packages:"
    echo ""
    echo "   Ubuntu/Debian:"
    echo "     sudo apt update"
    echo "     sudo apt install libwebkit2gtk-4.0-dev libgtk-3-dev pkg-config"
    echo ""
    echo "   CentOS/RHEL/Fedora:"
    echo "     sudo yum install webkit2gtk3-devel gtk3-devel pkgconfig"
    exit 1
fi

if ! pkg-config --exists gtk+-3.0; then
    echo "GTK3 development packages are missing."
    echo "   Please install "
    echo ""
    echo "   Ubuntu/Debian:"
    echo "     sudo apt update"
    echo "     sudo apt install libgtk-3-dev"
    echo ""
    echo "   CentOS/RHEL/Fedora:"
    echo "     sudo apt update"
    echo "     sudo yum install gtk3-devel"
    exit 1
    exit 1
fi

echo "All system dependencies found"
echo "Go version: $(go version)"

echo "Building executable..."
CGO_ENABLED=1 go build -o useragent-demo examples/useragent/main.go

echo ""
echo "Build completed successfully!"
echo "Executable created: $(pwd)/useragent-demo"
echo ""
echo "To run the demo:"
echo " ./useragent-demo"
echo ""
echo "Expected behavior:"
echo "   - Opens a window titled 'Basic Example'"
echo "   - Navigates to https://useragentstring.com/ for user agent detection"
echo "   - Displays the custom user agent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari'"
