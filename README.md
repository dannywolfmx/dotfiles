# Dotfiles

Personal configuration files for shell, development tools, and Emacs.

## Features

✨ **Modular Configuration** - Organized shell configs in separate files (env, path, aliases)  
🔄 **Automatic Backups** - Creates timestamped backups before overwriting files  
✅ **Validation** - Verifies source files exist before creating symlinks  
🧪 **Testing Suite** - Run `./test.sh` to verify installation  
🛡️ **Safe Installation** - Detects existing tools and skips reinstallation  
📦 **Easy Uninstall** - Remove symlinks and restore backups with `./uninstall.sh`

## Quick Start

```bash
git clone https://github.com/YOUR-USERNAME/dotfiles.git ~/Git/dotfiles
cd ~/Git/dotfiles
./install.sh
```

The installer will:
1. Check for required dependencies (git, curl, wget)
2. Optionally install tools (ZSH, Go, Doom Emacs)
3. Create backups of existing configs in `~/.dotfiles-backup/`
4. Create symlinks to your dotfiles

## What's Included

### Shell Configurations
- **`.profile`** - Main shell configuration, loads modular configs
- **`.bashrc`** - Bash-specific settings
- **`.zshrc`** - ZSH configuration with Oh My Zsh
- **`shell/`** - Modular configuration directory:
  - `env.sh` - Environment variables (Go, Android, Java)
  - `path.sh` - Consolidated PATH configuration
  - `aliases.sh` - Command aliases

### Development Tools
- **Emacs/Doom** - Doom Emacs configuration in `emacs/.doom.d/`
- **Go** - Latest Go installation in `~/.local/go`
- **ZSH** - With Oh My Zsh framework

## Installation Scripts

### Main Installation
```bash
./install.sh
```
Interactive installer that:
- Validates dependencies
- Offers optional tool installation
- Creates symlinks with backup
- Links shell modules

### Individual Tools

**Go Language**:
```bash
./tools/golang.sh
```
Installs latest Go version to `~/.local/go`

**ZSH + Oh My Zsh**:
```bash
./tools/zsh.sh
```
Installs ZSH and Oh My Zsh framework

**Doom Emacs**:
```bash
./emacs/install.sh
```
Installs Emacs (if needed) and Doom Emacs

### Testing
```bash
./test.sh
```
Verifies:
- Symlinks are valid
- Tools are installed
- PATH is configured correctly
- Shell modules exist

### Uninstallation
```bash
./uninstall.sh
```
Removes all symlinks and optionally restores backups

## Environment Variables

The modular shell configuration manages:

- **Go**: `$HOME/.local/go/bin` and `$HOME/go/bin`
- **Android SDK**: Auto-detected in `$HOME/workspace/android-sdk`
- **Java**: Auto-detected from common JDK paths
- **Flutter/Dart**: Auto-detected if installed
- **Doom Emacs**: `$HOME/.emacs.d/bin`

## Directory Structure

```
dotfiles/
├── install.sh          # Main installer
├── uninstall.sh        # Uninstaller
├── test.sh             # Test suite
├── .profile            # Main shell config
├── .bashrc             # Bash config
├── .zshrc              # ZSH config
├── shell/              # Modular configs
│   ├── env.sh          # Environment variables
│   ├── path.sh         # PATH configuration
│   └── aliases.sh      # Aliases
├── emacs/              # Emacs configuration
│   ├── install.sh      # Doom installer
│   └── .doom.d/        # Doom config
└── tools/              # Tool installers
    ├── golang.sh       # Go installer
    └── zsh.sh          # ZSH installer
```

## Backups

Backups are automatically created in `~/.dotfiles-backup/` with timestamps:
- `.profile_20260116_130845`
- `.bashrc_20260116_130845`
- etc.

## Notes

- For detailed org-mode documentation, see [README.org](README.org)
- The installer prompts before overwriting existing files
- Tools check for existing installations to avoid duplicates
- All scripts use `set -euo pipefail` for safety
- Paths are auto-detected when possible for portability

## Troubleshooting

**Command not found after installation:**
```bash
source ~/.profile
```
Or open a new terminal session.

**Test failures:**
Run `./test.sh` to diagnose issues and see detailed error messages.

**Restore from backup:**
```bash
./uninstall.sh  # Offers to restore latest backups
```

## License

See [LICENSE](LICENSE)
