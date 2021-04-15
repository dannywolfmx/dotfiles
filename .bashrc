# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOBIN

PATH="$HOME/.emacs.d/bin:$PATH"

CGO_ENABLED=1
alias firefox="flatpak run org.mozilla.firefox"
alias obs="flatpak run com.obsproject.Studio"
alias emacs="emacs -nw"
#To fix an stange behaviour in linux subsystem 
alias doom="$HOME/.emacs.d/bin/doom"