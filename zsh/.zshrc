bindkey -v

## Options: https://zsh.sourceforge.io/Doc/Release/Options.html
setopt autocd
setopt autopushd
setopt completeinword
setopt extendedglob
setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorespace
setopt histverify
setopt interactivecomments
setopt longlistjobs
setopt nobeep
setopt noflowcontrol
setopt promptsubst
setopt pushdignoredups
setopt sharehistory
setopt vi

# Do not enter command lines into the history list if they are duplicates of
# the previous event.
setopt hist_ignore_dups

## End Options

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

autoload -Uz colors
colors

autoload -Uz run-help
autoload -Uz run-help-git
unalias_run-help() {
    local its_type="$(whence -w run-help)"
    if [[ ${its_type##* } == 'alias' ]]; then
        unalias run-help
    fi
}; unalias_run-help; unset -f unalias_run-help
alias help='run-help'

##### COMPLETION #####
fpath+=~/.zfunc

autoload -Uz compinit
compinit

zmodload zsh/complist

bindkey -r '^[/'
bindkey '^?' backward-delete-char

zstyle '*' single-ignored show

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ":completion:*:commands" rehash true

# ignore internal zsh functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# process completion shows all processes with colors
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' command 'ps -A -o pid,user,cmd'
zstyle ':completion:*:*:*:*:processes' list-colors "=(#b) #([0-9]#)*=0=${color[green]}"
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'
##### END COMPLETION #####

command -v nvim &>/dev/null && alias vim=nvim
command -v lvim &>/dev/null && alias vim=lvim

alias history='fc -l 1'
alias c='clear'
alias itt='img2txt'
alias tmux='tmux -2'
alias grep='grep --color=always'
alias ls='exa'
alias cr='cargo run'
alias l='exa -@lgh'
alias ll='exa -@lgh'
alias lh='exa -@lgh'
alias la='exa -@algh'
alias lt='exa -@lgh --tree'
alias time='\time'
alias weather='curl -s http://wttr.in'
alias nvim_pluginstallall='nvim +PlugInstall +PlugClean +PlugUpdate +UpdateRemotePlugins'
alias gs='git status'
alias gd='git diff'
alias cat='bat -pp --theme="Visual Studio Dark+"'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"
base16_default-dark

# Syntax highlighting
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[comment]="fg=8,bold"

[ -f /usr/share/autojump/autojump.zsh ] && source /usr/share/autojump/autojump.zsh

# Begin FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
# End FZF

[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

alias sudo='sudo '

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias todo="vim $HOME/.todo.md"
[[ -f "$HOME/.todo.md" ]] && cat $HOME/.todo.md

source "$HOME/.zfunctions"

eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# fnm
export PATH="/home/mack/.local/share/fnm:$PATH"
eval "$(fnm env --shell=zsh --use-on-cd)"

export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"
