## Installed through Homebrew
# zsh-syntax-highlighting
[[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zsh-autosuggestions
[[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ajeetdsouza/zoxide
export "_ZO_DATA_DIR=$XDG_CONFIG_HOME/zoxide"
[[ -f "$HOMEBREW_PREFIX/bin/zoxide" ]] && eval "$(zoxide init zsh)"
