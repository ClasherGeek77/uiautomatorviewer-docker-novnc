# uiautomatorviewer-docker-novnc 🐳

[![Docker](https://img.shields.io/badge/Infrastructure-Docker-blue?logo=docker)]()
[![Android](https://img.shields.io/badge/Platform-Android-green?logo=android)]()

A containerized solution for running Android's **UI Automator Viewer** entirely within a web browser using Docker and noVNC. 

## 🎯 Objective
To solve the modern pain point of setting up Android SDK Studio solely to use the UI Automator Viewer component for determining Appium XPaths. This allows QA teams to inspect elements directly from a browser without installing bulky desktop applications.

## 🏗 Architecture
1. **Ubuntu Base Image**: A lightweight Linux environment.
2. **Android SDK cmdline-tools**: Stripped down SDK containing only the required tools.
3. **X11 & noVNC**: A virtual frame buffer and VNC server that streams the X11 display to a web-based HTML5 canvas.

## 🚀 Getting Started
```bash
docker-compose up -d
```
Then navigate to `http://localhost:6080` in your browser.

> *"I don't just automate tests. I build testers."* — Teddy Lioner
