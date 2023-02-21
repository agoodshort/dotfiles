# My chezmoi dotfiles

I will groom a little bit more this README later, for now here is the command I wanted to save somewhere.

```
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```

```
brew bundle dump --force --describe
brew bundle
brew autoremove
```

```
sudo apt install zsh
chsh -s $(which zsh)
```

```
/usr/local/opt/fzf/install --xdg --no-bash --no-fish --no-update-rc --key-bindings --completion
```

## To-Do

- [ ] Change keymaps for git view in neotree to match the ones from lazygit
- [ ] Review Fugitive usage
- [ ] Review steps to install zsh
- [ ] Review bashrc and profile (use only profile)
- [ ] Review required `brew casks/formula` to run the zsh or bash properly
- [ ] Review vim XDG location
- [ ] Add VSCode config to share how vim keybindings works
- [ ] Review the PowerToys config
- [ ] Using Scoop and Chocolatey as package manager (prioritze Scoop)


# Windows nvim

- requires nvm, node install and C

```
scoop install mingw
```
