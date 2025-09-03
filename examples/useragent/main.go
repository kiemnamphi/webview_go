package main

import webview "github.com/webview/webview_go"

func main() {
	w := webview.New(false)
	defer w.Destroy()
	w.SetTitle("Basic Example")
	w.SetSize(480, 320, webview.HintNone)
	w.SetUserAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari")
	// My Ip was blocked on https://www.whatismybrowser.com/detect/what-is-my-user-agent/, replace with https://useragentstring.com
	w.Navigate("https://useragentstring.com/")
	w.Run()
}
