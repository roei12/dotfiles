# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# vi mode binds
bindkey -v 
bindkey -M viins 'jk' vi-cmd-mode

# Autocomplete
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

complete -C aws_completer aws
complete -o nospace -C /opt/homebrew/bin/terraform terraform
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source <(COMPLETE=zsh jj)
source <(fzf --zsh)

## ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# History setup
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
HISTFILE=$HOME/.zhistory
SAVEHIST=100000
HISTSIZE=10000
HISTORY_IGNORE="(brew|cat|cd|dotfiles|git|jj|ln|ls|mkdir|mv|npm install|rm)"

## Bindings to navigate history
bindkey -M viins '\e[A' history-search-backward
bindkey -M viins '^P' history-search-backward
bindkey -M viins '\e[B' history-search-forward
bindkey -M viins '^N' history-search-forward

# Env and Aliases
export VISUAL=nvim
export EDITOR=nvim

alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias vim=nvim
alias e=$EDITOR
alias ls='eza --icons=auto'
alias cd='z'
