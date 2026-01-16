#!/bin/bash
set -euo pipefail

# Check if Go is already installed
if [ -x "$HOME/.local/go/bin/go" ]; then
    CURRENT_VERSION="$($HOME/.local/go/bin/go version | awk '{print $3}')"
    echo "✅ Go is already installed: ${CURRENT_VERSION}"
    echo "⏩ Skipping installation"
    exit 0
fi

# Ensure basic tools
sudo apt update
sudo apt install -y wget curl

# Get the latest golang release (extract only the version, first line)
GO_VERSION="$(curl -fsSL https://go.dev/VERSION?m=text | head -n1)"
GO_PACKAGE_INSTALLER="${GO_VERSION}.linux-amd64.tar.gz"
FILE_GO_PACKAGE="/tmp/${GO_PACKAGE_INSTALLER}"
[ -e "$FILE_GO_PACKAGE" ] && rm "$FILE_GO_PACKAGE"

echo "📦 Downloading ${GO_VERSION}..."

# Download Go package
wget "https://dl.google.com/go/${GO_PACKAGE_INSTALLER}" -O "$FILE_GO_PACKAGE"

# Install Go under user's local directory
mkdir -p "$HOME/.local"
rm -rf "$HOME/.local/go"
tar -C "$HOME/.local" -xzf "$FILE_GO_PACKAGE"

# Setup Go environment
export PATH="$HOME/.local/go/bin:$PATH"
export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"
mkdir -p "$GOBIN"

go install golang.org/x/tools/gopls@latest
