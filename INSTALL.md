## To review / Optional

### What did not install with brew

Skipping cask alacritty (on Linux) ## Using wezterm
Skipping cask amethyst (on Linux)
Skipping cask font-hack-nerd-font (on Linux) # to remove the tap for linux
Skipping cask google-chrome (on Linux)
Skipping cask karabiner-elements (on Linux)
Skipping cask lepton (on Linux) ## Do I still want to use that
Skipping cask obsidian (on Linux)
Skipping cask postman (on Linux)
Skipping cask slack (on Linux) # Using snap
Skipping cask visual-studio-code (on Linux) # Using snap
Skipping cask xquartz (on Linux)

### font-hack-nerd-font

Not needed, if I go ahead with using only nerd font

```
git clone --filter=blob:none --sparse git@agoodshort.github.com:ryanoasis/nerd-fonts
cd nerd-fonts
git sparse-checkout add patched-fonts/Hack
./install.sh Hack
```

### Notes

- https://github.com/Homebrew/homebrew-bundle
- Nice installation steps => https://github.com/tcardonne/dotfiles
- AppImage manager (look GItHUb)
- Flameshot
- Way to automate snap => https://github.com/twpayne/dotfiles/blob/798742d79da7186267083e3c6b37d2250248ba1d/home/.chezmoiscripts/linux/run_onchange_before_install-packages.sh.tmpl
- install wezterm through cask on MacOs
- Add the aws profiles
- SHortcut for ctrl+e to esc
