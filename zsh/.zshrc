# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

# Enable Zsh's extended globbing and null_glob options
setopt extended_glob null_glob

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
alias la="ls -a"
alias v="nvim"
alias gs="git status"
alias moco="python3 ~/git/moco-cli/app/main.py"

alias mkdirtoday="mkdir $(date +'%d-%m-%Y')"

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


export PATH="/opt/homebrew/opt/php@8.3/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.3/sbin:$PATH"
