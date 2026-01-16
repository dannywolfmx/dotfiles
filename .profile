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

# Load modular shell configurations
DOTFILES_DIR="$(dirname "$(readlink -f "$HOME/.profile")")"

if [ -f "$DOTFILES_DIR/shell/env.sh" ]; then
    source "$DOTFILES_DIR/shell/env.sh"
fi

if [ -f "$DOTFILES_DIR/shell/path.sh" ]; then
    source "$DOTFILES_DIR/shell/path.sh"
fi

if [ -f "$DOTFILES_DIR/shell/aliases.sh" ]; then
    source "$DOTFILES_DIR/shell/aliases.sh"
fi
