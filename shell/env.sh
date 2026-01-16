# Environment variables configuration

# GOLANG
export PATH="$HOME/.local/go/bin:$PATH"
export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"
export CGO_ENABLED=1

# Android SDK
# Use Android Studio standard location
if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
    export ANDROID_HOME="$ANDROID_SDK_ROOT"
fi

# Java (auto-detect if available, fallback to hardcoded)
if [ -d "/usr/lib/jvm/java-11-openjdk-amd64" ]; then
    export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
elif [ -d "/usr/lib/jvm/java-1.11.0-openjdk-amd64" ]; then
    export JAVA_HOME="/usr/lib/jvm/java-1.11.0-openjdk-amd64"
fi

# Linker (if exists)
if [ -x "/usr/bin/ld.lld-10" ]; then
    export LD="/usr/bin/ld.lld-10"
fi
