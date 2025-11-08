source $HOME/.config/bash/aliases.bash
source $HOME/.config/bash/sensible.bash

export PATH=$PATH:$HOME/.local/bin

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

eval -- "$(jj util completion bash)"
eval -- "$(starship init bash --print-full-init)"
eval -- "$(zoxide init bash)"
