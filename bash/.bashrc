# Source global definitions
export PATH="$PATH:$HOME/.local/bin"
source "$HOME/.cargo/env"

eval "$(starship init bash)"

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User defined functions and aliases
export LESS='-iFRX'
alias la='ls -al'
alias c='clear'
alias gs='git status'

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
