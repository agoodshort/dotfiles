# My chezmoi dotfiles

<!--toc:start-->

- [My chezmoi dotfiles](#my-chezmoi-dotfiles)
  - [To get started](#to-get-started)
    - [1. Setup ssh for GitHub](#1-setup-ssh-for-github)
      - [1.1. Create ssh key](#11-create-ssh-key)
      - [1.2. Associate the key with GitHub](#12-associate-the-key-with-github)
      - [1.3. Add the GitHub SSH key to known_host](#13-add-the-github-ssh-key-to-knownhost)
    - [2. Install Homebrew](#2-install-homebrew)
    - [3. Getting started with chezmoi](#3-getting-started-with-chezmoi)
    - [4. Set zsh (already by default the shell)](#4-set-zsh-already-by-default-the-shell)
    - [5. Configure node with nvm](#5-configure-node-with-nvm)
    - [6. Install yay (AUR helper)](#6-install-yay-aur-helper)
    - [7. Install packages](#7-install-packages)
    - [9. Keyboard mapping to review](#9-keyboard-mapping-to-review)
  - [To-Do](#to-do)
  - [References](#references)
    - [Git multi user](#git-multi-user)
  - [NEXT](#next) - [Install Kanagawa theme](#install-kanagawa-theme) - [Install regolith (should not be installed)](#install-regolith-should-not-be-installed)
  <!--toc:end-->

I will make this a little more readable later, for now here is the command I wanted to save somewhere.

## To get started

### 1. Setup ssh for GitHub

#### 1.1. Create ssh key

```sh
mkdir ~/.ssh && cd $_
ssh-keygen -t ed25519 -C "adrien.goodshort@gmail.com" -f "github-agoodshort"
pbcopy < ~/.ssh/github-agoodshort.pub # copy public key to clipboard
```

#### 1.2. Associate the key with GitHub

Add the copied key in your [GitHub Profile SSH keys](https://github.com/settings/keys).

#### 1.3. Add the GitHub SSH key to known_host

```sh
curl --silent https://api.github.com/meta \
  | jq --raw-output '"github.com "+.ssh_keys[]' >> ~/.ssh/known_hosts
```

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

### 6. Install yay (AUR helper)

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
- [ ] Should we set the API key through lastpass for wakatime and codeium
- [ ] Dont install docker through brew on Manjaro
- [ ] Add the wakatime key using lastpass
- [ ] `tap "wez/wezterm-linuxbrew"` only for llinux

## References

### Git multi user

- https://gist.github.com/alejandro-martin/aabe88cf15871121e076f66b65306610
- https://stackoverflow.com/a/74832574/13795415
- https://gist.github.com/rahularity/86da20fe3858e6b311de068201d279e3

## NEXT

```sh
cd ~/Coding/Personal
git clone --filter=blob:none --sparse git@agoodshort.github.com:ryanoasis/nerd-fonts
cd nerd-fonts
git sparse-checkout add patched-fonts/Hack
git sparse-checkout add patched-fonts/UbuntuMono
git sparse-checkout add patched-fonts/Ubuntu
./install.sh Hack
```

### Install Kanagawa theme

```
cd ~/Coding/Personal/
git clone git@agoodshort.github.com:Fausto-Korpsvart/Kanagawa-GKT-Theme.git
cd Kanagawa-GKT-Theme
cp -r themes/Kanagawa-B ~/.themes
cp -r themes/Kanagawa-B/gtk-4.0/* ~/.config/gtk-4.0/
```

### Install regolith (should not be installed)

```
wget -qO - https://regolith-desktop.org/regolith.key | gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null

echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.org/release-ubuntu-jammy-amd64 jammy main" | \
sudo tee /etc/apt/sources.list.d/regolith.list

sudo apt update
sudo apt install regolith-desktop regolith-compositor-picom-glx
sudo apt upgrade
```
