# My chezmoi dotfiles

<!--toc:start-->

- [My chezmoi dotfiles](#my-chezmoi-dotfiles) - [2. Install Homebrew](#2-install-homebrew) - [3. Getting started with chezmoi](#3-getting-started-with-chezmoi) - [4. Set zsh (already by default the shell)](#4-set-zsh-already-by-default-the-shell) - [5. Configure node with nvm](#5-configure-node-with-nvm) - [6. Install yay (AUR helper) and create the personal directory](#6-install-yay-aur-helper-and-create-the-personal-directory) - [7. Install packages](#7-install-packages) - [9. Keyboard mapping to review](#9-keyboard-mapping-to-review)
  - [To-Do](#to-do)
  - [References](#references) - [Git multi user](#git-multi-user) - [Install Kanagawa theme](#install-kanagawa-theme)
  <!--toc:end-->

I will make this a little more readable later, for now here is the command I wanted to save somewhere.

### 2. Install Homebrew

[Homebrew requirements for Linux](https://docs.brew.sh/Homebrew-on-Linux#requirements)

```sh
sudo  pacman -S base-devel
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Warning**: Make sure to follow the steps in next steps displayed after the installation.

### 3. Getting started with chezmoi

```sh
brew install chezmoi
chezmoi init --apply agoodshort
```

### 4. Set zsh (already by default the shell)

TODO: do not install zsh with brew if on arch

### 5. Configure node with nvm

```
nvm install lts/gallium
```

### 6. Install yay (AUR helper) and create the personal directory

```sh
mkdir -p ~/Coding/Personal && cd $_
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ../
rm -rf yay
```

### 7. Install packages

```sh
yay -Sy microsoft-edge-stable-bin \
flameshot-git \
postman-bin \
visual-studio-code-bin \
nosql-workbench \
sworkstyle \
zoom \
slack-desktop \
deskreen-bin
pacman -Sy docker \
brave-browser
sudo chmod 666 /var/run/docker.sock
xdg-settings set default-web-browser microsoft-edge.desktop
```

### 9. Keyboard mapping to review

TODO: needs to be saved

- Access to 3rd layer

## To-Do

- [ ] Review Fugitive usage
- [ ] Review bashrc and profile (use only profile)
- [ ] Review required `brew casks/formula` to run the zsh or bash properly
- [ ] Review vim XDG location
- [ ] Add VSCode config to share how vim keybindings works (or work on the neovim plguin)
- [ ] Review the PowerToys config (get the backup to be saved properly)
- [ ] Create template so that chezmoi points correctly to dotfiles and nvim config when in dashboard ( use {{ .chezmoi.homeDir}} )
- [ ] Auto update to latest lazylock if nvim config was changed
- [ ] brew should not install git on Linux
- [ ] Add `pbcopy` on Linux => https://ostechnix.com/how-to-use-pbcopy-and-pbpaste-commands-on-linux/
- [ ] balena etcher through brew
- [ ] Mission Control is left by default as karabiner keymaps are built on top of it
- [ ] List desktop to be assigned on MacOS and display (with the right click on icon)
- [ ] Install docker engine through brew in MacOS?

## References

### Git multi user

- https://gist.github.com/alejandro-martin/aabe88cf15871121e076f66b65306610
- https://stackoverflow.com/a/74832574/13795415
- https://gist.github.com/rahularity/86da20fe3858e6b311de068201d279e3

### Install Kanagawa theme

```
cd ~/Coding/Personal/
git clone git@agoodshort.github.com:Fausto-Korpsvart/Kanagawa-GKT-Theme.git
cd Kanagawa-GKT-Theme
cp -r themes/Kanagawa-B ~/.themes
cp -r themes/Kanagawa-B/gtk-4.0/* ~/.config/gtk-4.0/
```
