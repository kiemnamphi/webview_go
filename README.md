# SetUserAgent Implementation Guide

This repo is forked from https://github.com/webview/webview_go and adds custom implementation for Webview SetUserAgent. <br/>
This guide provides instructions for building and testing the `SetUserAgent` functionality in the webview_go library.

## Overview

The `SetUserAgent(string)` method allows you to customize the user agent string that the webview uses when making web requests. This is useful for:
- Web compatibility testing
- Analytics and tracking customization  
- Application identification
- Browser spoofing for specific web services

## Supported Platform

- **macOS**: Uses `[WKWebView setCustomUserAgent:]` (native WebKit API)
- **Linux**: Uses `webkit_settings_set_user_agent()` (WebKit2GTK)
- **Windows**: Uses WebView2

## Prerequisites

### macOS
- Xcode Command Line Tools: `xcode-select --install`
- Go 1.13+: `brew install go`

### Linux
TBU

## Build Scripts

### macOS Build Script
build-macos.sh - run this build script on MacOS to generate executable file **useragent-demo**

### Linux Build Script
TBU

## Usage Instructions

### Quick Start

1. **Clone the repository** (if not already done):
   ```bash
   git clone https://github.com/kiemnamphi/webview_go.git
   cd webview_go
   ```

2. **Run the appropriate build script**:
   
   **On macOS:**
   ```bash
   ./build-macos.sh
   ```
   
   **On Linux:**
   TBU

3. **Execute the demo**:
   ```bash
   ./useragent-demo
   ```

### What You Should See

When you run the executable, you should observe:

1. **Window Opens**: A native window titled "Basic Example"
2. **Custom User Agent Displayed**: The webpage shows your custom user agent string
3. **Expected User Agent**: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari", as it is hardcoded in useragent/main.go

### Testing Different User Agents

You can modify the `SetUserAgent()` call in the `useragent/main.go` to test different user agent strings:

```go
// Standard browser user agents
w.SetUserAgent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36")

// Custom application user agents  
w.SetUserAgent("MyApp/2.0 (Custom WebView Application)")

// Mobile user agents
w.SetUserAgent("Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15")
```

Then rebuild and run:
```bash
./build-macos.sh
./useragent-demo
```

## API Reference

### SetUserAgent Method

```go
func (w *webview) SetUserAgent(userAgent string)
```

**Parameters:**
- `userAgent`: The custom user agent string to set

**Usage:**
```go
w := webview.New(false)
defer w.Destroy()

// Set custom user agent before loading content
w.SetUserAgent("MyCustomApp/1.0")

// Load your content
w.Navigate("https://example.com")
// or
w.SetHtml("<html>...</html>")

w.Run()
```

**Important Notes:**
- Call `SetUserAgent()` **before** calling `Run()`
- Call `SetUserAgent()` **before** loading content with `Navigate()` or `SetHtml()`
- Empty strings are supported and will use the default user agent
