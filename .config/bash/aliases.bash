alias cat='batcat -pp -theme gruvbox-dark'
alias ls='eza'

run10 () {
    for i in $(seq 1 10)
    do
        $*
    done
}
