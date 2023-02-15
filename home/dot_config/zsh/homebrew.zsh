## Installed through Homebrew
# rupa/z
[[ -f "/usr/local/etc/profile.d/z.sh" ]] && source "/usr/local/etc/profile.d/z.sh"
export "_Z_DATA=$XDG_CONFIG_HOME/z"

# zsh-syntax-highlighting
[[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zsh-autosuggestions
[[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
