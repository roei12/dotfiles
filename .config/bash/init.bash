source $HOME/.config/bash/aliases.bash
source $HOME/.config/bash/sensible.bash
source $HOME/.config/bash/settings.bash

export PATH=$PATH:$HOME/.local/bin

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

if command -v jj >/dev/null; then
    eval -- "$(jj util completion bash)"
fi

if command -v starship >/dev/null; then
    eval -- "$(starship init bash --print-full-init)"
fi

if command -v zoxide >/dev/null; then
    eval -- "$(zoxide init bash)"
fi
