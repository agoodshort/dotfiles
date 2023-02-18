## Installed through Homebrew
# rupa/z
[[ -f "$HOMEBREW_PREFIX/etc/profile.d/z.sh" ]] && source "$HOMEBREW_PREFIX/etc/profile.d/z.sh"
export "_Z_DATA=$XDG_CONFIG_HOME/z"

# zsh-syntax-highlighting
[[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zsh-autosuggestions
[[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# skywind3000/z.lua
[[ -f "$HOMEBREW_PREFIX/share/z.lua/z.lua" ]] && eval "$(lua $HOMEBREW_PREFIX/share/z.lua/z.lua --init zsh)"
export "_ZL_DATA=$XDG_CONFIG_HOME/zlua"
