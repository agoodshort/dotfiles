# Windows environment

## Neovim

### Requirements

- nvm
- node
- C

### Steps

```bash
scoop install mingw
npm install -g tree-sitter-cli

cd C:\Users\Digital6\AppData\Local\nvim-data\site\pack\packer\start\telescope-fzf-native.nvim
make
```

chezmoi should create (or edit if not existing) the Powershell profile ($PROFILE) and have the line `Invoke-Expression (&starship init powershell)`

<https://github.com/twpayne/chezmoi/issues/2273>
