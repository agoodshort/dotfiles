# exa
alias l="exa --icons --group-directories-first"
alias ll="exa --icons --group-directories-first -la"
alias lg="exa --icons --group-directories-first --git -la"
function tree {
    if [[ "$1" != "" ]]
    then
        exa --tree "$1"
    else
        exa --tree
    fi
}

# bat
alias cat='bat'

# global
alias grep='grep --color'

# vim
# alias vim='VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc" vim'
