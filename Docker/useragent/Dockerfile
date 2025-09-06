# Docker container for testing webview_go SetUserAgent on Linux
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    # Go programming language
    golang-go \
    # WebView dependencies
    libwebkit2gtk-4.0-dev \
    libgtk-3-dev \
    pkg-config \
    # X11 dependencies for GUI
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxtst6 \
    libxi6 \
    # Additional tools
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set up Go environment
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
ENV CGO_ENABLED=1

# Create working directory
WORKDIR /app

# Copy the entire webview_go source code
COPY . .

RUN go build -o useragent-demo examples/useragent/main.go

# Create a simple test script
RUN echo '#!/bin/bash\n\
echo "Testing SetUserAgent on Linux (Docker)"\n\
echo "Go version: $(go version)"\n\
echo "WebKit2GTK version: $(pkg-config --modversion webkit2gtk-4.0)"\n\
echo "GTK3 version: $(pkg-config --modversion gtk+-3.0)"\n\
echo ""\n\
echo "Executable: $(ls -la useragent-demo)"\n\
echo ""\n\
if [ "$DISPLAY" = "" ]; then\n\
    echo "No DISPLAY environment variable set"\n\
    echo "   Run with X11 forwarding: docker run --rm -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix webview-linux-test"\n\
    exit 1\n\
fi\n\
echo "Starting SetUserAgent demo..."\n\
./useragent-demo\n\
' > /app/test.sh && chmod +x /app/test.sh

# Default command
CMD ["/app/test.sh"]
