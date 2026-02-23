# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

# Enable Zsh's extended globbing and null_glob options
setopt extended_glob null_glob

export GOPATH=$HOME/go

# Define an array of directories to add to PATH
path=(
    $path                           # Keep existing PATH entries
    $HOME/bin
    $HOME/.local/bin
    $GOPATH/bin
    $SCRIPTS
    /usr/local/bin
    /usr/local/sbin
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

# Export the updated PATH
export PATH


# Set to superior editing mode
set -o vi

export VISUAL=nvim
export EDITOR=nvim
export SCRIPTS="$HOME/scripts/"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=100000
HISTSIZE=100000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

#history by arrow keys
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)
autoload -U compinit; compinit
source ~/.zsh/fzf-tab.plugin.zsh
# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"
# ---- General aliases ----
alias la="eza -a"
alias ls="eza"
alias v="nvim"
alias gs="git status"
alias moco="python3 ~/git/moco-cli/app/main.py"
alias home="cd ~/"

alias mkdirtoday="mkdir $(date +'%d-%m-%Y')"

# Custom function to create, activate, and prep a venv
setup_venv() {
    # 1. Create the environment
    python3 -m venv .venv
    
    # 2. Activate it
    source .venv/bin/activate
    
    # 3. Upgrade pip immediately
    pip install --upgrade pip
    
    # 4. If a requirements.txt exists, install it automatically
    if [ -f "requirements.txt" ]; then
        echo "Found requirements.txt, installing dependencies..."
        pip install -r requirements.txt
    fi

    echo "Venv created, activated, and pip updated."
}

# Alias it to something short
alias venv="setup_venv"

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
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi

# Homebrew Umgebung
eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

eval "$(fnm env --use-on-cd)"


export PATH="/opt/homebrew/opt/php@8.3/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.3/sbin:$PATH"


export PATH="/usr/local/bin:$PATH"
