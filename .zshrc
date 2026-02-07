# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Plugins
if [[ $(uname) == "Linux" ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
else
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
fi

# vi mode binds
bindkey -v 
bindkey -M viins 'jk' vi-cmd-mode

# Autocomplete
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

complete -C aws_completer aws
complete -o nospace -C /opt/homebrew/bin/terraform terraform
eval "$(zoxide init zsh)"
source <(COMPLETE=zsh jj)
source <(fzf --zsh)
eval "$(uv generate-shell-completion zsh)"

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
alias cat='bat -p'
alias cd='z'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/roeil/.lmstudio/bin"
# End of LM Studio CLI section

source $HOME/secrets.env
