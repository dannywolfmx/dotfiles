#!/bin/bash
set -euo pipefail

# Parse command line arguments
ASSUME_YES=false
VERBOSE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -y|--yes)
            ASSUME_YES=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -y, --yes      Non-interactive mode, assume 'yes' to all prompts"
            echo "  -v, --verbose  Enable verbose output"
            echo "  -h, --help     Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Logging functions
log_verbose() {
    if [ "$VERBOSE" = true ]; then
        echo "🔍 [VERBOSE] $*"
    fi
}

log_info() {
    echo "ℹ️  $*"
}

log_success() {
    echo "✅ $*"
}

log_warning() {
    echo "⚠️  $*"
}

log_error() {
    echo "❌ $*"
}

# Prompt function that respects --yes flag
prompt_yes_no() {
    local message="$1"
    local default="${2:-N}"  # Default to No if not specified
    
    if [ "$ASSUME_YES" = true ]; then
        log_verbose "Auto-answering 'yes' due to --yes flag"
        return 0
    fi
    
    echo -n "$message"
    read -r answer
    
    if [ "$default" = "Y" ]; then
        # Default is Yes, so empty or non-N means yes
        if [ "$answer" != "${answer#[Nn]}" ]; then
            return 1
        fi
        return 0
    else
        # Default is No, so only explicit yes means yes
        if [ "$answer" = "${answer#[Nn]}" ] && [ -n "$answer" ]; then
            return 0
        fi
        return 1
    fi
}

# Check dependencies
echo "🔍 Checking dependencies..."
MISSING_DEPS=()

for cmd in git curl wget; do
    if ! command -v "$cmd" &> /dev/null; then
        MISSING_DEPS+=("$cmd")
    fi
done

if [ ${#MISSING_DEPS[@]} -gt 0 ]; then
    log_error "Missing required dependencies: ${MISSING_DEPS[*]}"
    echo ""
    echo "Please install them first:"
    echo "  Ubuntu/Debian: sudo apt install ${MISSING_DEPS[*]}"
    echo "  Fedora/RHEL:   sudo dnf install ${MISSING_DEPS[*]}"
    exit 1
fi
log_success "All dependencies found"
log_verbose "Dependencies: git, curl, wget"
echo ""

# Backup directory
BACKUP_DIR="$HOME/.dotfiles-backup"

# Create backup function
backup_file() {
    local target="$1"
    local name="$2"
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        local timestamp=$(date +%Y%m%d_%H%M%S)
        local backup_path="$BACKUP_DIR/${name}_${timestamp}"
        
        echo "📦 Backing up to: $backup_path"
        cp -rL "$target" "$backup_path" 2>/dev/null || mv "$target" "$backup_path"
    fi
}

link (){
    local test_flag="$1"
    local source_path="$2"
    local target_path="$3"
    local description="$4"
    
    # Validate source exists
    if [ ! -e "$source_path" ]; then
        log_error "Source $description does not exist: $source_path"
        return 1
    fi
    
    log_verbose "Source: $source_path -> Target: $target_path"

    # Check if the file or dir already exist
    if test "$test_flag" "$target_path"; then
         if ! prompt_yes_no "🚨 A $description detected, do you want to overwrite it? [Y/n] " "Y"; then
           log_info "Skipped $description"
           echo ""
           return 0
         fi
         
         # Backup before overwriting
         backup_file "$target_path" "$(basename "$target_path")"
    fi

    #Link the profile (remove old target then create symlink)
    rm -rf "$target_path"
    log_success "Linking the $description"
    log_verbose "Created symlink: $target_path -> $source_path"
    echo ""
    ln -s "$source_path" "$target_path"
    return 0
}

echo ""
echo "================================================"
echo "📦 Optional Tools Installation"
echo "================================================"
echo ""

# Initialize installation flags
INSTALL_ZSH="no"

# Ask about ZSH installation FIRST (before linking .zshrc)
if prompt_yes_no "🔧 Do you want to install ZSH and Oh My Zsh? [y/N] " "N"; then
    INSTALL_ZSH="yes"
    log_info "Installing ZSH..."
    bash "$PWD/tools/zsh.sh"
else
    log_info "Skipped ZSH installation"
fi

echo ""

# Ask about Golang installation
if prompt_yes_no "🔧 Do you want to install Golang? [y/N] " "N"; then
    log_info "Installing Golang..."
    bash "$PWD/tools/golang.sh"
else
    log_info "Skipped Golang installation"
fi

echo ""

# Ask about Node.js installation
if prompt_yes_no "🔧 Do you want to install Node.js? [y/N] " "N"; then
    log_info "Installing Node.js..."
    bash "$PWD/tools/node.sh"
else
    log_info "Skipped Node.js installation"
fi

echo ""

# Ask about Flutter installation
if prompt_yes_no "🔧 Do you want to install Flutter? [y/N] " "N"; then
    log_info "Installing Flutter..."
    bash "$PWD/tools/flutter.sh"
else
    log_info "Skipped Flutter installation"
fi

echo ""

# Ask about Doom Emacs installation
if prompt_yes_no "🔧 Do you want to install Doom Emacs? [y/N] " "N"; then
    log_info "Installing Doom Emacs..."
    bash "$PWD/emacs/install.sh"
else
    log_info "Skipped Doom Emacs installation"
fi

echo ""
echo "================================================"
echo "📝 Linking dotfiles"
echo "================================================"
echo ""

PROFILE_FILE="$HOME/.profile"
link -f "$PWD/.profile" "$PROFILE_FILE" ".profile file"

BASHFILE="$HOME/.bashrc"
link -f "$PWD/.bashrc" "$BASHFILE" ".bashrc file"

# Only link .zshrc if ZSH was installed (Oh My Zsh creates a default .zshrc)
if [ "$INSTALL_ZSH" = "yes" ]; then
    echo ""
    echo "⚠️  Oh My Zsh created a default .zshrc"
    echo "Your custom .zshrc will replace it now"
fi
ZSHRC_FILE="$HOME/.zshrc"
link -f "$PWD/.zshrc" "$ZSHRC_FILE" ".zshrc file"

DOOM_DIR="$HOME/.doom.d"
link -d "$PWD/emacs/.doom.d" "$DOOM_DIR" ".doom.d DIR"

# Link shell configuration directory
SHELL_DIR="$HOME/.config/dotfiles-shell"
mkdir -p "$HOME/.config"
link -d "$PWD/shell" "$SHELL_DIR" "shell configs DIR"

echo ""
echo "✅ Installation complete!"
echo ""
echo "💡 Run './test.sh' to verify the installation"
