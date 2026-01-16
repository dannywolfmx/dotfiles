# PATH configuration - consolidated in one place

# Build PATH array
PATH_DIRS=(
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.local/go/bin"
    "$HOME/go/bin"
    "$HOME/.emacs.d/bin"
)

# Android SDK paths (if directory exists)
if [ -n "${ANDROID_SDK_ROOT:-}" ] && [ -d "$ANDROID_SDK_ROOT" ]; then
    PATH_DIRS+=(
        "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
        "$ANDROID_SDK_ROOT/platform-tools"
        "$ANDROID_SDK_ROOT/emulator"
    )
fi

# Dart (if exists)
if [ -d "/usr/lib/dart/bin" ]; then
    PATH_DIRS+=("/usr/lib/dart/bin")
fi

# Flutter (if exists)
if [ -d "$HOME/.local/flutter/bin" ]; then
    PATH_DIRS+=("$HOME/.local/flutter/bin")
fi

# Add all directories to PATH (only if they exist)
for dir in "${PATH_DIRS[@]}"; do
    if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
        PATH="$dir:$PATH"
    fi
done

export PATH
