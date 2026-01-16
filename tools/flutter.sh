#!/bin/bash
set -euo pipefail

FLUTTER_DIR="$HOME/.local/flutter"

# Check if Flutter is already installed
if [ -x "$FLUTTER_DIR/bin/flutter" ]; then
    CURRENT_VERSION="$($FLUTTER_DIR/bin/flutter --version | head -n1)"
    echo "✅ Flutter is already installed: ${CURRENT_VERSION}"
    echo "⏩ Skipping installation"
    echo ""
    echo "💡 To upgrade Flutter, run: flutter upgrade"
    exit 0
fi

echo "📦 Installing Flutter..."

# Ensure git is available
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is required but not installed"
    exit 1
fi

# Create .local directory
mkdir -p "$HOME/.local"

# Clone Flutter repository
echo "📥 Cloning Flutter repository (this may take a while)..."
git clone https://github.com/flutter/flutter.git -b stable "$FLUTTER_DIR"

# Add to PATH temporarily for this session
export PATH="$PATH:$FLUTTER_DIR/bin"

echo ""
echo "🔧 Running Flutter doctor to download Dart SDK and dependencies..."
"$FLUTTER_DIR/bin/flutter" doctor

echo ""
echo "✅ Flutter installation complete!"
echo ""
echo "📍 Flutter installed at: $FLUTTER_DIR"
echo "🔄 Reload your shell to use flutter command:"
echo "   source ~/.profile"
echo ""
echo "💡 Run 'flutter doctor' to check for additional dependencies"
echo "💡 For Android development, you'll need Android SDK and Studio"
echo "💡 For iOS development (macOS only), you'll need Xcode"
