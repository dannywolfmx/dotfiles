#!/bin/bash
set -euo pipefail

# Check if ZSH is already installed
if command -v zsh &> /dev/null; then
    ZSH_VERSION="$(zsh --version | awk '{print $2}')"
    echo "✅ ZSH is already installed: zsh ${ZSH_VERSION}"
    
    # Check if Oh My Zsh is installed
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "✅ Oh My Zsh is already installed"
        echo "⏩ Skipping installation"
        exit 0
    else
        echo "📦 Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        exit 0
    fi
fi

# Ensure curl is available
sudo apt update || true
sudo apt install -y curl || true

echo "Installing zsh"
# fedora or redhat like
if [ -n "$(command -v dnf)" ]; then
    sudo dnf install -y zsh
elif [ -n "$(command -v apt)" ]; then
    sudo apt install -y zsh
else
    echo "Error on detect vendor (dnf | apt) to install zsh"
    exit 1
fi

echo "Installing oh my zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
