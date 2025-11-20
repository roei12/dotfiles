if command -v batcat >/dev/null; then
    alias cat='batcat -pp --theme gruvbox-dark'
fi

if command -v eza >/dev/null; then
    alias ls='eza'
fi

alias aider='aider --config '$HOME'/.config/aider/aider.yml'

run10 () {
    for i in $(seq 1 10)
    do
        $*
    done
}
