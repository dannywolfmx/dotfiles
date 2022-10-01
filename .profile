#setxkbmap -layout latam
#disable the "beep"
#setx -b

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# GOLANG
export GOPATH=$HOME/workspace/go
export GOBIN=$HOME/workspace/go/bin
export PATH=$PATH:$GOBIN
CGO_ENABLED=1

# android
export ANDROID_SDK_ROOT=$HOME/workspace/android-sdk/
export ANDROID_HOME=$ANDROID_SDK_ROOT

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

alias java='openjdk.java'
alias javac='openjdk.javac'
alias javadoc='openjdk.javadoc'
alias jar='openjdk.jar'
alias jarsigner='openjdk.jarsigner'
alias jlink='openjdk.jlink'
alias jpackage='openjdk.jpackage'
alias jwebserver='openjdk.jwebserver'
export CC=/usr/bin/clang-10
export CPP=/usr/bin/clang-cpp-10
export CXX=/usr/bin/clang++-10
export LD=/usr/bin/ld.lld-10
PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
PATH="$PATH:$HOME/workspace/android-sdk/platform-tools"
PATH="$PATH:$HOME/workspace/android-sdk/emulator"

PATH="$PATH:$HOME/.emacs.d/bin"

alias firefox="flatpak run org.mozilla.firefox"
alias obs="flatpak run com.obsproject.Studio"
#To fix an stange behaviour in linux subsystem 
alias doom="$HOME/.emacs.d/bin/doom"

#flutter dart
export PATH="$PATH:/usr/lib/dart/bin"
export PATH="$PATH:$HOME/workspace/flutter/bin"

#ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
   eval `ssh-agent -s`
   ssh-add ~/.ssh/gitlab
fi
