#!/bin/bash
set -e

echo "Building SetUserAgent example for macOS..."

# Check Go installation
if ! command -v go &> /dev/null; then
    echo "Go is not installed. Please install Go first."
    echo "   brew install go"
    exit 1
fi

echo "Go version: $(go version)"

echo "Setting up dependencies..."
echo "No dependencies needed for macOS"
echo ""

echo "Building executable..."
go build -o useragent-demo examples/useragent/main.go

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

