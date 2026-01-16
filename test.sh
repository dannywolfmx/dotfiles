#!/bin/bash
# Test script to verify dotfiles installation

set -euo pipefail

ERRORS=0
WARNINGS=0

echo "🧪 Running dotfiles tests..."
echo ""

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

error() {
    echo -e "${RED}❌ ERROR: $1${NC}"
    ((ERRORS++))
}

warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
    ((WARNINGS++))
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Test 1: Verify symlinks exist and are valid
echo "📋 Testing symlinks..."
test_symlink() {
    local link_path="$1"
    local name="$2"
    
    if [ ! -L "$link_path" ]; then
        error "$name is not a symlink: $link_path"
    elif [ ! -e "$link_path" ]; then
        error "$name is a broken symlink: $link_path"
    else
        local target=$(readlink -f "$link_path")
        success "$name -> $target"
    fi
}

test_symlink "$HOME/.profile" ".profile"
test_symlink "$HOME/.bashrc" ".bashrc"
test_symlink "$HOME/.zshrc" ".zshrc"

if [ -d "$HOME/.doom.d" ]; then
    test_symlink "$HOME/.doom.d" ".doom.d"
fi

echo ""

# Test 2: Verify installed tools
echo "🔧 Testing installed tools..."

test_command() {
    local cmd="$1"
    local name="$2"
    
    if command -v "$cmd" &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -n1 || echo "unknown")
        success "$name is installed: $version"
    else
        warning "$name is not installed"
    fi
}

test_command "go" "Go"
test_command "zsh" "ZSH"
test_command "emacs" "Emacs"
test_command "doom" "Doom Emacs"

echo ""

# Test 3: Verify PATH contains expected directories
echo "🛣️  Testing PATH configuration..."

test_in_path() {
    local dir="$1"
    local name="$2"
    
    if [[ ":$PATH:" == *":$dir:"* ]]; then
        success "$name is in PATH"
    else
        if [ -d "$dir" ]; then
            warning "$name directory exists but is not in PATH: $dir"
        fi
    fi
}

# Source the profile to get the latest PATH
source "$HOME/.profile" 2>/dev/null || true

test_in_path "$HOME/.local/bin" ".local/bin"
test_in_path "$HOME/go/bin" "Go bin"

if [ -d "$HOME/.emacs.d/bin" ]; then
    test_in_path "$HOME/.emacs.d/bin" "Emacs bin"
fi

echo ""

# Test 4: Verify shell modules exist
echo "📦 Testing shell modules..."

if [ -f "$HOME/Git/dotfiles/shell/env.sh" ]; then
    success "env.sh exists"
else
    error "shell/env.sh not found"
fi

if [ -f "$HOME/Git/dotfiles/shell/aliases.sh" ]; then
    success "aliases.sh exists"
else
    error "shell/aliases.sh not found"
fi

if [ -f "$HOME/Git/dotfiles/shell/path.sh" ]; then
    success "path.sh exists"
else
    error "shell/path.sh not found"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Test Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✅ All tests passed!${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  $WARNINGS warning(s)${NC}"
    exit 0
else
    echo -e "${RED}❌ $ERRORS error(s), $WARNINGS warning(s)${NC}"
    exit 1
fi
