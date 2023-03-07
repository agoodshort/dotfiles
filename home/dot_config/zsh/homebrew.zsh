## Homebrew config
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_BUNDLE_NO_LOCK=1

# zsh-syntax-highlighting
[[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zsh-autosuggestions
[[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

## ajeetdsouza/zoxide
if [[ -f "$HOMEBREW_PREFIX/bin/zoxide" ]]; then
    export "_ZO_DATA_DIR=$XDG_CONFIG_HOME/zoxide"
    eval "$(zoxide init zsh)"
fi
# junegunn/fzf - Required to use `zf` with zoxide (might be used by some other plugins)
[[ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ]] && source $XDG_CONFIG_HOME/fzf/fzf.zsh

# awscli
if [[ -f "$HOMEBREW_PREFIX/bin/aws" ]]; then
    export AWS_PROFILE=revanistaLocal
    export AWS_REGION=eu-west-1
fi

# starship
if [[ -f "$HOMEBREW_PREFIX/bin/starship" ]]; then
    eval "$(starship init zsh)"
    export "STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml"
fi

## nvm
if [[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" && -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ]]; then
    export NVM_DIR="$XDG_CONFIG_HOME/nvm"
    mkdir -p $NVM_DIR
    source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"  # This loads nvm
    source "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi
