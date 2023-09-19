# eza
alias l="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -la"
alias lg="eza --icons --group-directories-first --git -la"
function tree() {
    if [[ "$@" != "" ]]
    then
        eza --tree --icons --group-directories-first "$@"
    else
        eza --tree --icons --group-directories-first
    fi
}

# bat
alias cat='bat'

# global
alias grep='grep --color'

# vim
# alias vim='VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc" vim'
