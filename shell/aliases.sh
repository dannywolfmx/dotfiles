# Shell aliases

# Java aliases (only if openjdk commands exist)
if command -v openjdk.java &> /dev/null; then
    alias java='openjdk.java'
    alias javac='openjdk.javac'
    alias javadoc='openjdk.javadoc'
    alias jar='openjdk.jar'
    alias jarsigner='openjdk.jarsigner'
    alias jlink='openjdk.jlink'
    alias jpackage='openjdk.jpackage'
    alias jwebserver='openjdk.jwebserver'
fi

# Doom Emacs alias (fix for Linux subsystem)
if [ -x "$HOME/.emacs.d/bin/doom" ]; then
    alias doom="$HOME/.emacs.d/bin/doom"
fi
