# =============================================================================
# 1. EARLY INITIALIZATION (P10k Instant Prompt)
# =============================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# 2. ENVIRONMENT VARIABLES & HOMEBREW
# =============================================================================
# Set terminal for ghostty
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi

# Load Homebrew early so its paths and variables are available
eval "$(/opt/homebrew/bin/brew shellenv)"

setopt extended_glob null_glob
set -o vi

export GOPATH=$HOME/go
export SCRIPTS="$HOME/scripts/"
export VISUAL=nvim
export EDITOR=nvim

# =============================================================================
# 3. PATH CONFIGURATION (Clean Array Method)
# =============================================================================
path=(
    /opt/homebrew/opt/php@8.3/bin
    /opt/homebrew/opt/php@8.3/sbin
    /usr/local/bin
    /usr/local/sbin
    $HOME/bin
    $HOME/.local/bin
    $GOPATH/bin
    $SCRIPTS
    $path
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

# =============================================================================
# 4. HISTORY & PROMPT
# =============================================================================
HISTFILE=$HOME/.zhistory
SAVEHIST=100000
HISTSIZE=100000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# History by arrow keys
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Powerlevel10k configuration
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =============================================================================
# 5. ALIASES & FUNCTIONS
# =============================================================================
alias la="eza -a"
alias ls="eza"
alias v="nvim"
alias gs="git status"
alias moco="python3 ~/git/moco-cli/app/main.py"
alias home="cd ~/"
alias mkdirtoday="mkdir $(date +'%d-%m-%Y')"

alias venv="setup_venv"
setup_venv() {
    python3 -m venv .venv
    source .venv/bin/activate
    pip install --upgrade pip
    if [ -f "requirements.txt" ]; then
        echo "Found requirements.txt, installing dependencies..."
        pip install -r requirements.txt
    fi
    echo "Venv created, activated, and pip updated."
}

function f() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

function o() {
  local file
  file=$(fzf) && open "$file"
}

gc(){
    git commit -m "$1"
}

# =============================================================================
# 6. TOOL INITIALIZATIONS (Zoxide, FNM, FZF)
# =============================================================================
eval "$(zoxide init zsh)"
alias cd="z"

eval "$(fnm env --use-on-cd)"

source <(fzf --zsh)

# =============================================================================
# 7. ZSH PLUGINS & COMPLETIONS (Order Matters Here!)
# =============================================================================
autoload -U compinit; compinit

# Autosuggestions and tab completions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fzf-tab.plugin.zsh

# Syntax highlighting MUST be the absolute last thing loaded
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
