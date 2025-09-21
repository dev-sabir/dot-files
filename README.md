# 🚀 Modern Development Environment

> A comprehensive, beginner-friendly dotfiles setup featuring Neovim, tmux, and enhanced terminal tools

[![macOS](https://img.shields.io/badge/Platform-macOS-blue.svg)](https://www.apple.com/macos/)
[![Neovim](https://img.shields.io/badge/Neovim-0.11+-green.svg)](https://neovim.io/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## ✨ What You'll Get

- 🎯 **Modern Neovim** with LSP, autocompletion, and 30+ plugins
- 🖥️ **Enhanced Terminal** with tmux, zsh, and productivity tools
- 🎨 **Consistent Dark Theme** across all applications
- ⚡ **Optimized Workflow** for modern development
- 📚 **Complete Documentation** for beginners and experts

---

<details>
<summary>📋 Table of Contents</summary>

- [Quick Start](#-quick-start)
- [Platform Compatibility](#-platform-compatibility)
- [Installation](#-installation)
- [Vim Basics for Beginners](#-vim-basics-for-beginners)
- [Neovim Technical Reference](#%EF%B8%8F-neovim-technical-reference)
- [Tmux Complete Guide](#%EF%B8%8F-tmux-complete-guide)
- [Terminal Tools](#-terminal-tools)
- [Customization](#-customization)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)

</details>

---

## ⚡ Quick Start

**One command to rule them all:**

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

**What happens next:**
1. 📦 Installs all required tools via Homebrew
2. 🔗 Creates symlinks to your home directory
3. 🎨 Sets up consistent theming
4. 🚀 Ready to code in under 5 minutes!

---

## 🖥️ Platform Compatibility

| Platform | Status | Notes |
|----------|--------|-------|
| **macOS** | ✅ Fully Supported | Optimized for Apple Silicon & Intel |
| **Linux** | ⚠️ Manual Setup Required | Install script needs adaptation |
| **Windows** | ❌ Not Supported | Consider WSL2 with Linux setup |

> **Note:** The automated install script is currently macOS-only. Linux users can manually follow the configuration files.

---

## 📦 Installation

<details>
<summary><b>Prerequisites</b></summary>

### Required
- **macOS 10.15+** (Catalina or newer)
- **Homebrew** (will be installed automatically if missing)
- **Git** (usually pre-installed on macOS)

### Recommended
- **iTerm2** or **Wezterm** for best terminal experience
- **MesloLGS NF Font** (installed automatically)

</details>

<details>
<summary><b>Automated Installation (Recommended)</b></summary>

### Step 1: Clone the Repository
```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Step 2: Run the Install Script
```bash
./install.sh
```

### Step 3: Post-Installation Setup
```bash
# Restart your terminal
# Set terminal font to 'MesloLGS NF' in preferences
# Configure zsh theme
p10k configure

# Start tmux and install plugins
tmux
# Press Ctrl-a + I to install tmux plugins

# Open Neovim to install plugins
nvim
# Plugins install automatically on first launch
```

</details>

<details>
<summary><b>Manual Installation</b></summary>

### Core Tools
```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install essential packages
brew install neovim tmux zsh git curl node ripgrep fd fzf bat eza zoxide thefuck yazi powerlevel10k zsh-autosuggestions zsh-syntax-highlighting

# Install Nerd Font
brew install --cask font-meslo-lg-nerd-font
```

### Configuration Files
```bash
# Create config directory
mkdir -p ~/.config

# Symlink configurations
ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/.wezterm.lua ~/.wezterm.lua
```

</details>

---

## 🎯 Vim Basics for Beginners

<details>
<summary><b>Understanding Vim Modes</b></summary>

Vim has different "modes" for different tasks:

| Mode | Key | Purpose | How to Exit |
|------|-----|---------|-------------|
| **NORMAL** | `ESC` | Navigation & commands | Default mode |
| **INSERT** | `i` | Type text like normal editor | `ESC` or `jk` |
| **VISUAL** | `v` | Select text | `ESC` |
| **VISUAL-BLOCK** | `Ctrl-v` | Select rectangular blocks | `ESC` |
| **COMMAND** | `:` | Run commands like save/quit | `ESC` or `Enter` |

**💡 Pro Tip:** Our config lets you use `jk` to exit insert mode instead of reaching for `ESC`!

</details>

<details>
<summary><b>Essential Navigation</b></summary>

### Basic Movement (Normal Mode)
```
   k
h  ↑  l    ←hjkl→ are your new arrow keys
   j
```

| Key | Action | Example |
|-----|--------|---------|
| `h` | Move left | Move one character left |
| `j` | Move down | Move one line down |
| `k` | Move up | Move one line up |
| `l` | Move right | Move one character right |

### Line Navigation
| Key | Action | Example |
|-----|--------|---------|
| `0` | Start of line | Jump to first character |
| `^` | First non-blank character | Skip whitespace |
| `$` | End of line | Jump to last character |

### Word Movement
| Key | Action | Example |
|-----|--------|---------|
| `w` | Next word start | Jump forward by words |
| `b` | Previous word start | Jump backward by words |
| `e` | Next word end | Jump to end of words |

### Document Navigation
| Key | Action | Example |
|-----|--------|---------|
| `gg` | First line | Jump to top of file |
| `G` | Last line | Jump to bottom of file |
| `{number}G` | Specific line | `42G` jumps to line 42 |

</details>

<details>
<summary><b>Essential Editing Commands</b></summary>

### Entering Insert Mode
| Key | Action | Cursor Position |
|-----|--------|-----------------|
| `i` | Insert | Before cursor |
| `a` | Append | After cursor |
| `A` | Append line | End of line |
| `o` | Open line below | New line below |
| `O` | Open line above | New line above |

### Deleting Text
| Key | Action | Example |
|-----|--------|---------|
| `x` | Delete character | Delete char under cursor |
| `dd` | Delete line | Delete entire line |
| `dw` | Delete word | Delete from cursor to end of word |
| `d$` | Delete to end | Delete from cursor to end of line |

### Copying and Pasting
| Key | Action | Example |
|-----|--------|---------|
| `yy` | Copy line | Copy entire line |
| `yw` | Copy word | Copy word under cursor |
| `p` | Paste after | Paste after cursor |
| `P` | Paste before | Paste before cursor |

### Undo and Redo
| Key | Action | Example |
|-----|--------|---------|
| `u` | Undo | Undo last change |
| `Ctrl-r` | Redo | Redo undone change |
| `.` | Repeat | Repeat last change |

</details>

<details>
<summary><b>Text Objects (Super Powerful!)</b></summary>

Text objects let you operate on "things" rather than just characters:

### Inner vs Around
- **Inner (`i`)**: Contents only
- **Around (`a`)**: Contents + surrounding characters

### Common Text Objects
| Object | Description | Example |
|--------|-------------|---------|
| `w` | Word | `diw` = delete inner word |
| `s` | Sentence | `dis` = delete sentence |
| `p` | Paragraph | `dip` = delete paragraph |
| `"` | Quoted text | `di"` = delete inside quotes |
| `'` | Single quotes | `da'` = delete around single quotes |
| `(` or `)` | Parentheses | `di(` = delete inside parentheses |
| `{` or `}` | Braces | `da{` = delete around braces |
| `[` or `]` | Brackets | `di[` = delete inside brackets |

### Powerful Combinations
```vim
diw    " Delete inner word
daw    " Delete around word (includes spaces)
ci"    " Change inside quotes
ya(    " Yank around parentheses
```

</details>

<details>
<summary><b>Essential Commands</b></summary>

### File Operations
| Command | Action | Example |
|---------|--------|---------|
| `:w` | Save file | Write changes to disk |
| `:q` | Quit | Exit Vim |
| `:wq` | Save and quit | Write and exit |
| `:q!` | Force quit | Exit without saving |
| `:e filename` | Edit file | Open another file |

### Search and Replace
| Command | Action | Example |
|---------|--------|---------|
| `/pattern` | Search forward | `/hello` finds "hello" |
| `?pattern` | Search backward | `?hello` finds "hello" backward |
| `n` | Next match | Jump to next search result |
| `N` | Previous match | Jump to previous search result |
| `:s/old/new/` | Replace on line | Replace first occurrence |
| `:s/old/new/g` | Replace all on line | Replace all occurrences |
| `:%s/old/new/g` | Replace in file | Replace all in entire file |

</details>

---

## 🛠️ Neovim Technical Reference

<details>
<summary><b>Leader Key Configuration</b></summary>

The leader key is your gateway to custom commands. In our setup:

**Leader Key: `Space`**

All custom keybindings start with pressing the spacebar, then the command key(s).

</details>

<details>
<summary><b>File Operations</b></summary>

### File Navigation
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>ff` | **Find Files** | Search and open files in current directory |
| `<leader>fr` | **Recent Files** | Open recently used files |
| `<leader>fs` | **Find String** | Search for text across all files |
| `<leader>fc` | **Find under Cursor** | Search for word under cursor |
| `<leader>ft` | **Find TODOs** | Find TODO comments in project |

### File Tree (nvim-tree)
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>ee` | **Toggle File Tree** | Open/close file explorer |
| `<leader>ef` | **Focus File Tree** | Open file tree and focus on current file |
| `<leader>ec` | **Collapse File Tree** | Collapse all folders |
| `<leader>er` | **Refresh File Tree** | Refresh file tree |

**File Tree Navigation:**
- `Enter` or `o` - Open file/folder
- `a` - Create new file
- `d` - Delete file/folder
- `r` - Rename file/folder
- `c` - Copy file
- `x` - Cut file

</details>

<details>
<summary><b>LSP (Language Server Protocol) Features</b></summary>

### Code Navigation
| Keybinding | Action | Description |
|------------|--------|-------------|
| `gd` | **Go to Definition** | Jump to where function/variable is defined |
| `gD` | **Go to Declaration** | Jump to declaration (like header files) |
| `gi` | **Go to Implementation** | Jump to implementation |
| `gt` | **Go to Type Definition** | Jump to type definition |
| `gR` | **Show References** | Show all places this symbol is used |
| `K` | **Hover Documentation** | Show documentation for symbol under cursor |

### Code Actions
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>ca` | **Code Actions** | Show available code fixes/refactors |
| `<leader>rn` | **Rename Symbol** | Rename variable/function across project |
| `<leader>rs` | **Restart LSP** | Restart language server |

### Diagnostics (Error/Warning Navigation)
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>d` | **Show Line Diagnostics** | Show errors/warnings on current line |
| `<leader>D` | **Show Buffer Diagnostics** | Show all errors/warnings in file |
| `[d` | **Previous Diagnostic** | Jump to previous error/warning |
| `]d` | **Next Diagnostic** | Jump to next error/warning |

</details>

<details>
<summary><b>Window and Buffer Management</b></summary>

### Window Splitting
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>sv` | **Split Vertically** | Split window left/right |
| `<leader>sh` | **Split Horizontally** | Split window top/bottom |
| `<leader>se` | **Equal Splits** | Make all splits equal size |
| `<leader>sx` | **Close Split** | Close current split window |

### Tab Management
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>to` | **Open New Tab** | Create new tab |
| `<leader>tx` | **Close Tab** | Close current tab |
| `<leader>tn` | **Next Tab** | Go to next tab |
| `<leader>tp` | **Previous Tab** | Go to previous tab |
| `<leader>tf` | **File to New Tab** | Open current file in new tab |

### Buffer Navigation
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>b` | **Buffer List** | Show all open buffers |
| `<leader>bp` | **Previous Buffer** | Switch to previous buffer |
| `<leader>bn` | **Next Buffer** | Switch to next buffer |
| `<leader>bd` | **Delete Buffer** | Close current buffer |

</details>

<details>
<summary><b>Editing Enhancements</b></summary>

### Quick Utilities
| Keybinding | Action | Description |
|------------|--------|-------------|
| `jk` | **Exit Insert Mode** | Alternative to ESC key |
| `<leader>nh` | **Clear Highlights** | Clear search highlights |
| `<leader>+` | **Increment Number** | Increase number under cursor |
| `<leader>-` | **Decrement Number** | Decrease number under cursor |

### Comments
| Keybinding | Action | Description |
|------------|--------|-------------|
| `gcc` | **Toggle Line Comment** | Comment/uncomment current line |
| `gc` | **Toggle Comment** | Comment/uncomment selection (visual mode) |

### Text Manipulation
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>s` | **Find and Replace** | Substitute text in current line |
| `<leader>S` | **Find and Replace All** | Substitute text in entire file |

</details>

<details>
<summary><b>Git Integration</b></summary>

### Git Operations
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>gg` | **Lazygit** | Open interactive git interface |
| `<leader>gs` | **Git Status** | Show git status |
| `<leader>gc` | **Git Commit** | Commit changes |
| `<leader>gp` | **Git Push** | Push to remote |

### Git Signs (in-editor)
| Keybinding | Action | Description |
|------------|--------|-------------|
| `]c` | **Next Change** | Jump to next git change |
| `[c` | **Previous Change** | Jump to previous git change |
| `<leader>hp` | **Preview Hunk** | Preview git change |
| `<leader>hr` | **Reset Hunk** | Reset git change |

</details>

<details>
<summary><b>Advanced Features</b></summary>

### Session Management
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>wr` | **Restore Session** | Restore previous session |
| `<leader>ws` | **Save Session** | Save current session |

### Plugin Management
| Command | Action | Description |
|---------|--------|-------------|
| `:Lazy` | **Plugin Manager** | Open Lazy.nvim interface |
| `:Mason` | **LSP Manager** | Open Mason LSP installer |
| `:checkhealth` | **Health Check** | Check Neovim configuration |

### Terminal Integration
| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>tf` | **Toggle Terminal** | Open floating terminal |
| `<leader>th` | **Horizontal Terminal** | Open terminal below |
| `<leader>tv` | **Vertical Terminal** | Open terminal to the side |

</details>

---

## 🖥️ Tmux Complete Guide

<details>
<summary><b>Tmux Basics</b></summary>

### What is Tmux?
Tmux (Terminal Multiplexer) lets you:
- 📱 Split your terminal into multiple panes
- 📂 Create multiple windows (like browser tabs)
- 🔄 Keep sessions running even when disconnected
- 🚀 Boost productivity with keyboard shortcuts

### Prefix Key
**All tmux commands start with the prefix key: `Ctrl-a`**

**Usage Pattern:**
1. Press `Ctrl-a` (prefix)
2. Release both keys
3. Press the command key

</details>

<details>
<summary><b>Session Management</b></summary>

### Basic Session Commands
| Command | Action | Description |
|---------|--------|-------------|
| `tmux` | **Start Session** | Create new tmux session |
| `tmux new -s name` | **Named Session** | Create session with specific name |
| `tmux ls` | **List Sessions** | Show all active sessions |
| `tmux attach -t name` | **Attach Session** | Connect to existing session |
| `tmux kill-session -t name` | **Kill Session** | End specific session |

### Inside Tmux
| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl-a d` | **Detach** | Leave session (keeps running) |
| `Ctrl-a $` | **Rename Session** | Change session name |

</details>

<details>
<summary><b>Window Management</b></summary>

### Window Operations
| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl-a c` | **Create Window** | New window (like browser tab) |
| `Ctrl-a ,` | **Rename Window** | Change window name |
| `Ctrl-a &` | **Kill Window** | Close current window |

### Window Navigation
| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl-a n` | **Next Window** | Move to next window |
| `Ctrl-a p` | **Previous Window** | Move to previous window |
| `Ctrl-a 0-9` | **Window by Number** | Jump to specific window |
| `Ctrl-a l` | **Last Window** | Switch to last used window |

</details>

<details>
<summary><b>Pane Management</b></summary>

### Creating Panes
| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl-a \|` | **Vertical Split** | Split pane left/right |
| `Ctrl-a -` | **Horizontal Split** | Split pane top/bottom |

### Pane Navigation
| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl-a h` | **Move Left** | Focus pane to the left |
| `Ctrl-a j` | **Move Down** | Focus pane below |
| `Ctrl-a k` | **Move Up** | Focus pane above |
| `Ctrl-a l` | **Move Right** | Focus pane to the right |

### Pane Resizing
| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl-a H` | **Resize Left** | Make pane wider (left) |
| `Ctrl-a J` | **Resize Down** | Make pane taller (down) |
| `Ctrl-a K` | **Resize Up** | Make pane taller (up) |
| `Ctrl-a L` | **Resize Right** | Make pane wider (right) |

### Pane Operations
| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl-a m` | **Maximize Pane** | Toggle pane zoom (fullscreen) |
| `Ctrl-a x` | **Kill Pane** | Close current pane |
| `Ctrl-a !` | **Break Pane** | Move pane to new window |

</details>

<details>
<summary><b>Copy Mode (Vim-style)</b></summary>

### Entering Copy Mode
| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl-a [` | **Enter Copy Mode** | Start text selection |

### Copy Mode Navigation (Vim keys)
| Keybinding | Action | Description |
|------------|--------|-------------|
| `h,j,k,l` | **Move Cursor** | Navigate like Vim |
| `w,b` | **Word Movement** | Jump by words |
| `0,$` | **Line Movement** | Start/end of line |
| `g,G` | **Document Movement** | First/last line |

### Text Selection
| Keybinding | Action | Description |
|------------|--------|-------------|
| `v` | **Start Selection** | Begin highlighting text |
| `y` | **Copy Selection** | Copy highlighted text |
| `ESC` | **Exit Copy Mode** | Return to normal mode |

### Pasting
| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl-a ]` | **Paste** | Paste copied text |

</details>

<details>
<summary><b>Configuration Reload</b></summary>

### Reloading Config
| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl-a r` | **Reload Config** | Apply .tmux.conf changes |

</details>

<details>
<summary><b>Plugin Features</b></summary>

Our tmux setup includes powerful plugins:

### vim-tmux-navigator
- Seamless navigation between Vim and tmux panes
- Use `Ctrl-h/j/k/l` to move between Vim splits and tmux panes

### tmux-resurrect
- Automatically saves tmux sessions
- Restores sessions after computer restart

### tmux-continuum
- Continuous saving of tmux environment
- Automatic restore on tmux start

### Tokyo Night Theme
- Beautiful dark theme matching Neovim
- Consistent visual experience

</details>

---

## 🔧 Terminal Tools

<details>
<summary><b>Enhanced CLI Tools</b></summary>

Our setup replaces standard CLI tools with modern, enhanced versions:

### File Operations
| Tool | Replaces | Description | Example |
|------|----------|-------------|---------|
| **eza** | `ls` | Better file listing with icons | `ls` shows files with colors and icons |
| **bat** | `cat` | Syntax highlighting for file viewing | `bat filename.js` shows JavaScript with syntax highlighting |
| **fd** | `find` | Faster and easier file searching | `fd pattern` finds files matching pattern |
| **ripgrep** | `grep` | Blazing fast text search | `rg "function"` searches for "function" in all files |

### Navigation
| Tool | Replaces | Description | Example |
|------|----------|-------------|---------|
| **zoxide** | `cd` | Smart directory jumping | `z proj` jumps to project directory |
| **fzf** | N/A | Fuzzy finder for everything | `Ctrl-r` for command history search |

### Utilities
| Tool | Purpose | Description | Example |
|------|---------|-------------|---------|
| **thefuck** | Command correction | Fixes typos in commands | Type `fuck` after a typo |
| **yazi** | File manager | Terminal-based file browser | `y` opens file manager |

</details>

<details>
<summary><b>Zsh Configuration</b></summary>

### Powerlevel10k Theme
- 🚀 **Instant prompt** for fast terminal startup
- 📊 **Git status** in prompt
- 🌳 **Directory info** with smart truncation
- ⚡ **Command execution time** display

### Auto-suggestions
- 💡 **Command completion** based on history
- ⏰ **Real-time suggestions** as you type
- 🔮 **Intelligent predictions**

### Syntax Highlighting
- 🎨 **Color-coded commands** for validity
- 🚨 **Error highlighting** for invalid commands
- 📝 **Parameter highlighting**

### Useful Aliases
| Alias | Command | Description |
|-------|---------|-------------|
| `reload-zsh` | `source ~/.zshrc` | Reload zsh configuration |
| `edit-zsh` | `nvim ~/.zshrc` | Edit zsh configuration |
| `ls` | `eza --icons=always` | Enhanced file listing |
| `cd` | `z` | Smart directory navigation |

</details>

---

## 🎨 Customization

<details>
<summary><b>Changing Themes</b></summary>

### Neovim Theme
Edit `.config/nvim/lua/sabir/plugins/colorscheme.lua`:
```lua
return {
  "folke/tokyonight.nvim", -- Change this to your preferred theme
  -- Popular alternatives:
  -- "catppuccin/nvim"
  -- "EdenEast/nightfox.nvim"
  -- "rose-pine/neovim"
}
```

### Terminal Theme
The setup includes multiple terminal themes in `.config/alacritty/themes/`

### Tmux Theme
Edit `.tmux.conf` to change the theme plugin:
```bash
set -g @plugin 'fabioluciano/tmux-tokyo-night'
# Alternatives:
# set -g @plugin 'catppuccin/tmux'
# set -g @plugin 'egel/tmux-gruvbox'
```

</details>

<details>
<summary><b>Adding Neovim Plugins</b></summary>

### Step 1: Create Plugin File
Create a new file in `.config/nvim/lua/sabir/plugins/`:
```lua
-- .config/nvim/lua/sabir/plugins/my-plugin.lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration here
  end,
}
```

### Step 2: Restart Neovim
Lazy.nvim will automatically detect and install the new plugin.

### Popular Plugin Suggestions
- **nvim-surround**: Manipulate surroundings (quotes, brackets)
- **vim-visual-multi**: Multiple cursors
- **gitsigns**: Git integration
- **indent-blankline**: Indentation guides

</details>

<details>
<summary><b>Custom Keybindings</b></summary>

Add custom keybindings in `.config/nvim/lua/sabir/core/keymaps.lua`:

```lua
local keymap = vim.keymap

-- Example: Map <leader>w to save file quickly
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Example: Map <leader>q to quit
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
```

</details>

---

## 🚨 Troubleshooting

<details>
<summary><b>Common Issues</b></summary>

### Neovim Issues

**Problem: Plugins not loading**
```bash
# Check Lazy.nvim status
nvim -c "Lazy"

# Health check
nvim -c "checkhealth"
```

**Problem: LSP not working**
```bash
# Check Mason status
nvim -c "Mason"

# Restart LSP
# In Neovim: <leader>rs
```

**Problem: Treesitter errors**
```bash
# Update parsers
nvim -c "TSUpdate"

# Install specific parser
nvim -c "TSInstall <language>"
```

### Tmux Issues

**Problem: Plugins not working**
```bash
# Install tmux plugins
# In tmux: Ctrl-a + I

# Reload tmux config
tmux source-file ~/.tmux.conf
```

**Problem: Colors look wrong**
```bash
# Check terminal color support
echo $TERM

# Should be: tmux-256color or screen-256color
```

### Terminal Issues

**Problem: Font icons not showing**
1. Install MesloLGS NF font: `brew install --cask font-meslo-lg-nerd-font`
2. Set terminal font to "MesloLGS NF"
3. Restart terminal

**Problem: Zsh theme not loading**
```bash
# Reconfigure Powerlevel10k
p10k configure

# Check theme installation
brew list powerlevel10k
```

</details>

<details>
<summary><b>Performance Issues</b></summary>

### Slow Startup
1. **Check plugin count**: Too many plugins can slow startup
2. **Lazy loading**: Most plugins are configured to load on demand
3. **Profile startup**: Use `nvim --startuptime startup.log` to identify slow plugins

### Large Files
- Disable treesitter for large files
- Use `:syntax off` to disable syntax highlighting
- Consider using `bat` instead of opening in Neovim

</details>

<details>
<summary><b>Getting Help</b></summary>

### Documentation
- **Neovim**: `:help` in Neovim
- **Tmux**: `man tmux` in terminal
- **Plugins**: Check plugin documentation on GitHub

### Community
- [Neovim Discourse](https://neovim.discourse.group/)
- [r/neovim](https://reddit.com/r/neovim)
- [Tmux Wiki](https://github.com/tmux/tmux/wiki)

### Issue Reporting
If you find bugs in this configuration:
1. Check existing issues
2. Provide system information (OS, Neovim version)
3. Include error messages
4. Describe steps to reproduce

</details>

---

## 🤝 Contributing

<details>
<summary><b>How to Contribute</b></summary>

### Reporting Issues
1. **Search existing issues** first
2. **Use issue templates** when available
3. **Provide detailed information**:
   - Operating system and version
   - Neovim version (`nvim --version`)
   - Steps to reproduce
   - Expected vs actual behavior

### Suggesting Features
1. **Check if feature already exists**
2. **Explain the use case**
3. **Provide examples** if possible
4. **Consider backwards compatibility**

### Code Contributions
1. **Fork the repository**
2. **Create feature branch**: `git checkout -b feature/amazing-feature`
3. **Follow existing code style**
4. **Test your changes thoroughly**
5. **Update documentation** if needed
6. **Submit pull request**

### Documentation Improvements
- Fix typos or unclear instructions
- Add missing information
- Improve examples
- Update outdated content

</details>

---

## 🙏 Credits and Inspiration

This configuration is built on the shoulders of giants:

### Primary Inspiration
- **[Josean Martinez](https://github.com/josean-dev/dev-environment-files)** - Base Neovim configuration and development environment
- **[Josean's Vim Cheatsheet](https://www.josean.com/posts/vim-essentials-cheatsheet)** - Comprehensive Vim basics guide

### Key Technologies
- **[Neovim](https://neovim.io/)** - Hyperextensible Vim-based text editor
- **[Lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager
- **[Mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP installer
- **[Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[Tmux](https://github.com/tmux/tmux)** - Terminal multiplexer
- **[Powerlevel10k](https://github.com/romkatv/powerlevel10k)** - Zsh theme

### Community
- **[r/neovim](https://reddit.com/r/neovim)** - Amazing community support
- **[Neovim Discourse](https://neovim.discourse.group/)** - Official discussions
- **[Dotfiles community](https://dotfiles.github.io/)** - Inspiration and best practices

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ⭐ Star History

If this setup helped you become more productive, consider giving it a star! ⭐

---

<div align="center">

**Happy Coding! 🚀**

*Made with ❤️ for developers who love efficiency*

</div>