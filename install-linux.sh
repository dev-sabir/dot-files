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

# Detect Linux distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        VERSION=$VERSION_ID
    else
        print_error "Cannot detect Linux distribution"
        exit 1
    fi
}

# Check if running on Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    print_error "This script is designed for Linux. Use install.sh for macOS."
    exit 1
fi

print_status "🚀 Setting up your awesome development environment on Linux..."

# Detect distribution
detect_distro
print_status "📍 Detected: $DISTRO $VERSION"

# Function to install packages based on distro
install_packages() {
    case $DISTRO in
        ubuntu|debian|pop|linuxmint)
            print_status "🔄 Updating package lists..."
            sudo apt update

            print_status "📦 Installing core development tools..."

            # Core packages
            sudo apt install -y \
                neovim \
                tmux \
                zsh \
                git \
                curl \
                nodejs \
                npm \
                build-essential \
                software-properties-common \
                wget \
                unzip

            # Enhanced tools - some need different names on Ubuntu
            print_status "🛠️ Installing enhanced CLI tools..."
            sudo apt install -y \
                ripgrep \
                fd-find \
                fzf \
                bat \
                zoxide

            # Create fd symlink for Ubuntu (fd-find -> fd)
            if command -v fdfind &> /dev/null && ! command -v fd &> /dev/null; then
                mkdir -p ~/.local/bin
                ln -sf $(which fdfind) ~/.local/bin/fd
                print_success "Created fd symlink for fdfind"
            fi

            # Create batcat symlink for Ubuntu (batcat -> bat)
            if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
                mkdir -p ~/.local/bin
                ln -sf $(which batcat) ~/.local/bin/bat
                print_success "Created bat symlink for batcat"
            fi

            # Install eza (better ls) - needs to be installed manually
            if ! command -v eza &> /dev/null; then
                print_status "Installing eza..."
                wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
                echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
                sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
                sudo apt update
                sudo apt install -y eza
            fi

            # Install thefuck
            if ! command -v thefuck &> /dev/null; then
                print_status "Installing thefuck..."
                pip3 install --user thefuck
            fi

            # Install yazi
            if ! command -v yazi &> /dev/null; then
                print_status "Installing yazi (terminal file manager)..."
                cargo install --locked yazi-fm yazi-cli || {
                    print_warning "Failed to install yazi via cargo. Skipping..."
                }
            fi
            ;;

        fedora|rhel|centos)
            print_status "🔄 Updating package lists..."
            sudo dnf update -y

            print_status "📦 Installing core development tools..."
            sudo dnf install -y \
                neovim \
                tmux \
                zsh \
                git \
                curl \
                nodejs \
                npm \
                gcc \
                gcc-c++ \
                make \
                wget \
                unzip \
                python3-pip

            # Enhanced tools
            print_status "🛠️ Installing enhanced CLI tools..."
            sudo dnf install -y \
                ripgrep \
                fd-find \
                fzf \
                bat \
                zoxide

            # Install eza
            if ! command -v eza &> /dev/null; then
                print_status "Installing eza..."
                sudo dnf install -y eza
            fi

            # Install thefuck
            if ! command -v thefuck &> /dev/null; then
                print_status "Installing thefuck..."
                pip3 install --user thefuck
            fi
            ;;

        arch|manjaro)
            print_status "🔄 Updating package database..."
            sudo pacman -Syu --noconfirm

            print_status "📦 Installing core development tools..."
            sudo pacman -S --noconfirm \
                neovim \
                tmux \
                zsh \
                git \
                curl \
                nodejs \
                npm \
                base-devel \
                wget \
                unzip \
                python-pip

            # Enhanced tools
            print_status "🛠️ Installing enhanced CLI tools..."
            sudo pacman -S --noconfirm \
                ripgrep \
                fd \
                fzf \
                bat \
                eza \
                zoxide

            # Install thefuck
            if ! command -v thefuck &> /dev/null; then
                print_status "Installing thefuck..."
                pip install --user thefuck
            fi

            # Install yazi
            if ! command -v yazi &> /dev/null; then
                print_status "Installing yazi..."
                sudo pacman -S --noconfirm yazi
            fi
            ;;

        *)
            print_error "Unsupported distribution: $DISTRO"
            print_error "Supported: Ubuntu, Debian, Fedora, RHEL, CentOS, Arch Linux, Manjaro"
            exit 1
            ;;
    esac
}

# Install ZSH plugins
install_zsh_plugins() {
    print_status "🔌 Installing ZSH plugins..."

    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"

    # Install powerlevel10k
    if [ ! -d "$HOME/.config/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
        print_success "Powerlevel10k installed"
    else
        print_success "Powerlevel10k already installed"
    fi

    # Install zsh-autosuggestions
    if [ ! -d "$HOME/.config/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh-autosuggestions
        print_success "zsh-autosuggestions installed"
    else
        print_success "zsh-autosuggestions already installed"
    fi

    # Install zsh-syntax-highlighting
    if [ ! -d "$HOME/.config/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh-syntax-highlighting
        print_success "zsh-syntax-highlighting installed"
    else
        print_success "zsh-syntax-highlighting already installed"
    fi
}

# Install Nerd Font
install_nerd_font() {
    print_status "🔤 Installing Nerd Font..."

    # Create fonts directory
    mkdir -p ~/.local/share/fonts

    # Download MesloLGS NF font files
    FONT_DIR="$HOME/.local/share/fonts"
    FONT_BASE_URL="https://github.com/romkatv/powerlevel10k-media/raw/master"

    FONTS=(
        "MesloLGS%20NF%20Regular.ttf"
        "MesloLGS%20NF%20Bold.ttf"
        "MesloLGS%20NF%20Italic.ttf"
        "MesloLGS%20NF%20Bold%20Italic.ttf"
    )

    for font in "${FONTS[@]}"; do
        font_name=$(echo $font | sed 's/%20/ /g')
        if [ ! -f "$FONT_DIR/$font_name" ]; then
            print_status "Downloading $font_name..."
            wget -q "$FONT_BASE_URL/$font" -O "$FONT_DIR/$font_name"
        fi
    done

    # Update font cache
    fc-cache -fv
    print_success "Nerd Font installed. Please set your terminal font to 'MesloLGS NF'"
}

# Install Deno for peek.nvim
install_deno() {
    if ! command -v deno &> /dev/null; then
        print_status "📦 Installing Deno for markdown preview..."
        curl -fsSL https://deno.land/install.sh | sh

        # Add to PATH for current session
        export DENO_INSTALL="$HOME/.deno"
        export PATH="$DENO_INSTALL/bin:$PATH"

        print_success "Deno installed"
    else
        print_success "Deno already installed"
    fi
}

# Main installation
install_packages
install_zsh_plugins
install_nerd_font
install_deno

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

# Add ~/.local/bin to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
    print_success "Added ~/.local/bin to PATH"
fi

# Add Deno to PATH
if [ -d "$HOME/.deno" ] && [[ ":$PATH:" != *":$HOME/.deno/bin:"* ]]; then
    echo 'export DENO_INSTALL="$HOME/.deno"' >> ~/.bashrc
    echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc
    echo 'export DENO_INSTALL="$HOME/.deno"' >> ~/.zshrc
    echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.zshrc
    print_success "Added Deno to PATH"
fi

# Change default shell to zsh if not already
if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/usr/bin/zsh" ]; then
    print_status "🐚 Changing default shell to zsh..."
    chsh -s $(which zsh)
    print_warning "Shell changed to zsh. Please restart your terminal."
fi

print_success "✅ Setup complete!"
print_status ""
print_status "🎉 Next steps:"
print_status "1. Restart your terminal or run: source ~/.zshrc"
print_status "2. Set your terminal font to 'MesloLGS NF'"
print_status "3. Run 'p10k configure' to setup your zsh theme"
print_status "4. Open tmux and press Ctrl-a + I to install tmux plugins"
print_status "5. Open Neovim with 'nvim' - plugins will install automatically"
print_status "6. Run :checkhealth in Neovim to verify everything is working"
print_status ""
print_status "📚 Check the README.md for Vim basics and keybindings!"
print_status "🎯 Start with 'nvim' to begin your journey!"
print_status ""
print_status "💡 If you encounter any issues, check your PATH includes:"
print_status "   - $HOME/.local/bin (for custom binaries)"
print_status "   - $HOME/.deno/bin (for Deno)"