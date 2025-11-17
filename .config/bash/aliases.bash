alias cat='batcat -pp --theme gruvbox-dark'
alias ls='eza'

alias aider='aider --config '$HOME'/.config/aider/aider.yml'

run10 () {
    for i in $(seq 1 10)
    do
        $*
    done
}
