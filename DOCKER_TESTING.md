# Docker Testing Guide for SetUserAgent on Linux

This guide helps you test the SetUserAgent functionality on Linux from your macOS machine using Docker.

## Quick Setup

### 1. Install Prerequisites
```bash
# Install Docker Desktop
# Download from: https://www.docker.com/products/docker-desktop/

# Install XQuartz (X11 server for GUI forwarding)
brew install --cask xquartz
```

**Important**: After installing XQuartz, you must:
 - Config XQuartz to Allow connections from network clients: Open Xquarz/Settings/Security Tab, enable "Allow connections from network clients"
 - Log out and log back in (or restart your Mac) for it to work properly.

### 2. One-Command Testing
```bash
./docker-test-linux.sh
```

This script automatically:
- Checks if Docker is running
- Verifies XQuartz is available
- Builds Ubuntu container with WebKit2GTK
- Sets up X11 forwarding
- Runs the SetUserAgent demo
- Displays Linux GUI on macOS

## What the Docker Container Includes

### Base System
- **Ubuntu 22.04** (stable, well-supported)
- **Go 1.18+** (from official Ubuntu packages)

### WebView Dependencies
- **WebKit2GTK 4.0** (web rendering engine)
- **GTK3** (GUI toolkit)
- **pkg-config** (build system)

### X11 Support
- **X11 development libraries** for GUI forwarding
- **Display forwarding** to macOS via XQuartz

### Build Process
The container automatically:
1. Builds the executable with CGO enabled
2. Create a bash script to run useragent binary as an entry point

## Expected Results

When the Docker test runs successfully, you should see:

### Console Output
```
Docker Linux Testing Script for SetUserAgent
===============================================
Docker is running
XQuartz is available
Building Docker image for Linux testing...
Docker image built successfully
Setting up X11 forwarding...
X11 forwarding configured
Running Linux container with GUI support...

Testing SetUserAgent on Linux (Docker)
Go version: go version go1.18.1 linux/arm64
WebKit2GTK version: 2.48.5
GTK3 version: 3.24.33
Starting SetUserAgent demo...
```

### GUI Window
- **Window Title**: "Basic Example"
- **Content**: whatismybrowser.com user agent detection page
- **User Agent Displayed**: `Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari`
- **Browser Detection**: Shows "Chrome" instead of "WebKit" (proving the user agent was successfully changed)

## Manual Docker Commands

If you prefer step-by-step control:

```bash
# 1. Build the image
docker build -f Docker/useragent/Dockerfile -t webview-linux-test .

# 2. Start XQuartz (if not already running)
open -a XQuartz

# 3. Allow X11 connections from localhost
xhost +localhost

# 4. Run the container with GUI forwarding
docker run --rm \
  -e DISPLAY=host.docker.internal:0 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  webview-linux-test
```

## Troubleshooting

### Problem: "Docker is not running"
**Solution**: Start Docker Desktop from Applications

### Problem: "XQuartz is not installed"
**Solution**: 
```bash
brew install --cask xquartz
# Then log out and log back in
```

### Problem: No GUI window appears
**Solutions**:
1. Check XQuartz is running: `ps aux | grep -i xquartz`
2. Restart XQuartz: `killall XQuartz && open -a XQuartz`
3. Reset X11 permissions: `xhost +localhost`

### Problem: "Cannot connect to display"
**Solution**: Make sure XQuartz allows network connections:
1. Open XQuartz/Settings/Security Tab
2. Check "Allow connections from network clients"
3. Restart XQuartz

### Problem: Build fails with missing packages
**Solution**: The Dockerfile handles all dependencies automatically. If build fails, try:
```bash
# Clean Docker cache and rebuild
docker system prune -f
docker build --no-cache -t webview-linux-test .
```
