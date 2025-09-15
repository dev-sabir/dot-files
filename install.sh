#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper function for colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS. Please adapt for your system."
    exit 1
fi

print_status "🚀 Setting up your awesome development environment..."

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    print_warning "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew
print_status "🔄 Updating Homebrew..."
brew update

# Install required packages
print_status "📦 Installing core development tools..."

CORE_PACKAGES=(
    "neovim"
    "tmux"
    "zsh"
    "git"
    "curl"
    "node"
)

ENHANCED_TOOLS=(
    "ripgrep"          # Better grep
    "fd"               # Better find
    "fzf"              # Fuzzy finder
    "bat"              # Better cat
    "eza"              # Better ls
    "zoxide"           # Better cd
    "thefuck"          # Command correction
    "yazi"             # Terminal file manager
    "powerlevel10k"    # ZSH theme
)

ZSH_PLUGINS=(
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

# Install core packages
for package in "${CORE_PACKAGES[@]}"; do
    if brew list "$package" &>/dev/null; then
        print_success "$package is already installed"
    else
        print_status "Installing $package..."
        brew install "$package"
    fi
done

# Install enhanced tools
for package in "${ENHANCED_TOOLS[@]}"; do
    if brew list "$package" &>/dev/null; then
        print_success "$package is already installed"
    else
        print_status "Installing $package..."
        brew install "$package"
    fi
done

# Install ZSH plugins
for package in "${ZSH_PLUGINS[@]}"; do
    if brew list "$package" &>/dev/null; then
        print_success "$package is already installed"
    else
        print_status "Installing $package..."
        brew install "$package"
    fi
done

# Install Nerd Font (required for icons)
print_status "🔤 Installing Nerd Font..."
if ! brew list --cask font-meslo-lg-nerd-font &>/dev/null; then
    brew install --cask font-meslo-lg-nerd-font
    print_warning "Please set your terminal font to 'MesloLGS NF' in your terminal preferences"
else
    print_success "Nerd font is already installed"
fi

# Create backups and setup directories
print_status "📁 Setting up configuration directories..."

# Backup existing configs
CONFIGS=("nvim" "alacritty" "sketchybar")
for config in "${CONFIGS[@]}"; do
    if [ -d "$HOME/.config/$config" ]; then
        print_warning "Existing $config config found. Creating backup..."
        mv "$HOME/.config/$config" "$HOME/.config/$config.backup.$(date +%Y%m%d_%H%M%S)"
    fi
done

# Backup dotfiles
DOTFILES=(".zshrc" ".tmux.conf" ".wezterm.lua")
for dotfile in "${DOTFILES[@]}"; do
    if [ -f "$HOME/$dotfile" ]; then
        print_warning "Existing $dotfile found. Creating backup..."
        mv "$HOME/$dotfile" "$HOME/$dotfile.backup.$(date +%Y%m%d_%H%M%S)"
    fi
done

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Create symlinks
print_status "🔗 Creating symlinks..."

# Neovim config
ln -sf "$(pwd)/.config/nvim" "$HOME/.config/nvim"

# Other configs
if [ -d "$(pwd)/.config/alacritty" ]; then
    ln -sf "$(pwd)/.config/alacritty" "$HOME/.config/alacritty"
fi

if [ -d "$(pwd)/.config/sketchybar" ]; then
    ln -sf "$(pwd)/.config/sketchybar" "$HOME/.config/sketchybar"
fi

# Dotfiles
ln -sf "$(pwd)/.zshrc" "$HOME/.zshrc"
ln -sf "$(pwd)/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$(pwd)/.wezterm.lua" "$HOME/.wezterm.lua"

# Install TPM (Tmux Plugin Manager)
print_status "🔌 Installing Tmux Plugin Manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    print_success "TPM installed. Start tmux and press prefix + I to install plugins"
else
    print_success "TPM is already installed"
fi

# Setup fzf-git.sh
print_status "🔧 Setting up fzf-git integration..."
if [ ! -d "$HOME/fzf-git.sh" ]; then
    git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh
else
    print_success "fzf-git.sh is already installed"
fi

# Change default shell to zsh if not already
if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/usr/local/bin/zsh" ] && [ "$SHELL" != "/opt/homebrew/bin/zsh" ]; then
    print_status "🐚 Changing default shell to zsh..."
    chsh -s $(which zsh)
    print_warning "Shell changed to zsh. Please restart your terminal."
fi

print_success "✅ Setup complete!"
print_status ""
print_status "🎉 Next steps:"
print_status "1. Restart your terminal"
print_status "2. Set your terminal font to 'MesloLGS NF'"
print_status "3. Run 'p10k configure' to setup your zsh theme"
print_status "4. Open tmux and press Ctrl-a + I to install tmux plugins"
print_status "5. Open Neovim with 'nvim' - plugins will install automatically"
print_status "6. Run :checkhealth in Neovim to verify everything is working"
print_status ""
print_status "📚 Check the README.md for Vim basics and keybindings!"
print_status "🎯 Start with 'nvim' to begin your journey!"