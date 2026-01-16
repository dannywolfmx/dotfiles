#!/bin/bash
set -euo pipefail

#Set the current script directory
#https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Check if Emacs is installed
if ! command -v emacs &> /dev/null; then
    echo "⚠️  Emacs is not installed"
    echo "📦 Installing Emacs..."
    
    if [ -n "$(command -v dnf)" ]; then
        sudo dnf install -y emacs
    elif [ -n "$(command -v apt)" ]; then
        sudo apt update
        sudo apt install -y emacs
    else
        echo "❌ Error: Could not detect package manager (dnf | apt)"
        exit 1
    fi
    
    echo "✅ Emacs installed successfully"
else
    EMACS_VERSION="$(emacs --version | head -n1)"
    echo "✅ Emacs is already installed: ${EMACS_VERSION}"
fi

# Check if Doom Emacs is already installed
if [ -x "$HOME/.emacs.d/bin/doom" ]; then
    echo "✅ Doom Emacs is already installed"
    echo -n "🚨 Do you want to reinstall it? [y/N] "
    read -r answer
    if [ "$answer" != "${answer#[Nn]}" ] || [ -z "$answer" ]; then
        echo "⏩ Skipping installation"
        exit 0
    fi
    echo "🔄 Reinstalling Doom Emacs..."
fi

#Delete .emacs.d
[ -e "$HOME/.emacs.d" ] && rm -rf "$HOME/.emacs.d"
#install doom
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
#If doom already exist delete
[ -e "$HOME/.doom.d" ] && rm -r "$HOME/.doom.d"
#soft link from the current (PWD) doom.d directory, to the home directory
ln -s "$DIR/.doom.d" "$HOME/.doom.d"

#sync to doom
"$HOME/.emacs.d/bin/doom" sync
