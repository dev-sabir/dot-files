# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Powerlevel10k theme
if [[ -f ~/.config/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source ~/powerlevel10k/powerlevel10k.zsh-theme
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Load zsh plugins
if [[ -f ~/.config/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source ~/.config/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f ~/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source ~/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add custom paths here
# export PATH=$PATH:$HOME/.your-custom-path

# Ruby environment (rbenv)
if command -v rbenv &> /dev/null; then
  export PATH="$HOME/.rbenv/shims:$PATH"
fi

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
if command -v fzf &> /dev/null; then
  # Try new --zsh flag first, fallback to sourcing files
  if fzf --zsh &>/dev/null; then
    eval "$(fzf --zsh)"
  else
    # Fallback for older fzf versions
    [[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
    [[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
  fi
fi

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

if [[ -f ~/fzf-git.sh/fzf-git.sh ]]; then
  source ~/fzf-git.sh/fzf-git.sh
fi

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# ---- TheFuck -----

# thefuck alias (disabled due to Python 3.12 compatibility issues)
# if command -v thefuck &> /dev/null; then
#   eval $(thefuck --alias)
#   eval $(thefuck --alias fk)
# fi

# ---- Zoxide (better cd) ----
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

alias python="python3"

# Set up PATH for Linux

# --- Yazi Setup ---
export EDITOR="nvim"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
export PATH="$HOME/.local/bin:$PATH"

# Deno environment
if [ -f "$HOME/.deno/env" ]; then
  . "$HOME/.deno/env"
fi