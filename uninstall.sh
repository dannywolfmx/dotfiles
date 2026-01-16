#!/bin/bash
set -euo pipefail

echo ""
echo "================================================"
echo "🗑️  Dotfiles Uninstaller"
echo "================================================"
echo ""
echo "⚠️  This will remove all symlinks created by install.sh"
echo ""

# Ask for confirmation
echo -n "Are you sure you want to uninstall? [y/N] "
read -r answer
if [ "$answer" != "${answer#[Nn]}" ] || [ -z "$answer" ]; then
    echo "❌ Uninstall cancelled"
    exit 0
fi

echo ""
echo "Removing symlinks..."

# Function to remove symlink
remove_link() {
    local path="$1"
    local name="$2"
    
    if [ -L "$path" ]; then
        rm "$path"
        echo "✅ Removed $name symlink"
    elif [ -e "$path" ]; then
        echo "⚠️  $name exists but is not a symlink, skipping"
    else
        echo "ℹ️  $name does not exist, skipping"
    fi
}

# Remove shell config symlinks
remove_link "$HOME/.profile" ".profile"
remove_link "$HOME/.bashrc" ".bashrc"
remove_link "$HOME/.zshrc" ".zshrc"

# Remove Doom Emacs config
remove_link "$HOME/.doom.d" ".doom.d"

# Remove shell modules
remove_link "$HOME/.config/dotfiles-shell" "shell configs"

echo ""
echo "================================================"
echo "📦 Backup Restoration"
echo "================================================"
echo ""

BACKUP_DIR="$HOME/.dotfiles-backup"

if [ -d "$BACKUP_DIR" ]; then
    echo "Backups found in: $BACKUP_DIR"
    echo ""
    ls -lh "$BACKUP_DIR"
    echo ""
    echo -n "Do you want to restore the most recent backups? [y/N] "
    read -r answer
    
    if [ "$answer" = "${answer#[Nn]}" ] && [ -n "$answer" ]; then
        # Restore most recent backup for each file
        for file in .profile .bashrc .zshrc .doom.d; do
            # Find most recent backup
            LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/${file}* 2>/dev/null | head -n1)
            
            if [ -n "$LATEST_BACKUP" ]; then
                TARGET="$HOME/$file"
                if [ -e "$TARGET" ]; then
                    echo "⚠️  $TARGET already exists, skipping restore"
                else
                    cp -r "$LATEST_BACKUP" "$TARGET"
                    echo "✅ Restored $file from backup"
                fi
            fi
        done
        
        echo ""
        echo "💡 You can manually review backups in: $BACKUP_DIR"
    else
        echo "⏩ Backup restoration skipped"
        echo "💡 Your backups are still available in: $BACKUP_DIR"
    fi
else
    echo "ℹ️  No backup directory found"
fi

echo ""
echo "✅ Uninstall complete!"
echo ""
echo "Note: This script does NOT uninstall tools (Go, ZSH, Emacs, etc.)"
echo "      Use your package manager to remove them if needed."
