#!/bin/bash
set -euo pipefail

# Check if Node.js is already installed
if command -v node &> /dev/null; then
    CURRENT_VERSION="$(node --version)"
    echo "✅ Node.js is already installed: ${CURRENT_VERSION}"
    
    if command -v npm &> /dev/null; then
        NPM_VERSION="$(npm --version)"
        echo "✅ npm is already installed: ${NPM_VERSION}"
    fi
    
    echo "⏩ Skipping installation"
    exit 0
fi

# Check if NVM is already installed
NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    echo "✅ NVM is already installed"
    \. "$NVM_DIR/nvm.sh"
else
    echo "📦 Installing NVM (Node Version Manager)..."
    
    # Download and install nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    
    # Load nvm for current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    echo "✅ NVM installed successfully"
fi

echo ""
echo "📦 Installing Node.js LTS via NVM..."

# Install latest LTS version
nvm install --lts

# Set it as default
nvm alias default 'lts/*'

echo ""
echo "✅ Node.js installed successfully!"
echo "  Node.js: $(node --version)"
echo "  npm: $(npm --version)"
echo "  NVM: $(nvm --version)"

# Install common global packages (no sudo needed with nvm!)
echo ""
echo "📦 Installing common global npm packages..."
npm install -g yarn pnpm typescript eslint prettier

echo ""
echo "✅ Node.js setup complete!"
echo "  Node.js: $(node --version)"
echo "  npm: $(npm --version)"
echo "  yarn: $(yarn --version 2>/dev/null || echo 'not installed')"
echo "  pnpm: $(pnpm --version 2>/dev/null || echo 'not installed')"
echo ""
echo "💡 NVM commands:"
echo "  nvm install 20      - Install Node.js v20"
echo "  nvm use 20          - Use Node.js v20"
echo "  nvm ls              - List installed versions"
echo "  nvm ls-remote       - List available versions"
