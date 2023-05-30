# My chezmoi dotfiles

<!--toc:start-->

- [My chezmoi dotfiles](#my-chezmoi-dotfiles)
  - [To get started](#to-get-started)
    - [1. Setup ssh for GitHub](#1-setup-ssh-for-github)
      - [1.1. Create ssh key](#11-create-ssh-key)
      - [1.2. Associate the key with GitHub](#12-associate-the-key-with-github)
    - [2. Install Homebrew](#2-install-homebrew)
      - [2.1. Linux requirements](#21-linux-requirements)
      - [2.2. Installation](#22-installation)
    - [3. Getting started with chezmoi](#3-getting-started-with-chezmoi)
    - [4. Set zsh as default shell](#4-set-zsh-as-default-shell)
    - [5. Add the GitHub SSH key to known host](#5-add-the-github-ssh-key-to-known-host)
    - [5. Configure node with nvm](#5-configure-node-with-nvm)
    - [6. Create the Coding folder](#6-create-the-coding-folder)
  - [Linux specific](#linux-specific)
    - [1. Install Microsoft Edge](#1-install-microsoft-edge)
    - [2. Install docker](#2-install-docker)
    - [3. Basic snaps](#3-basic-snaps)
    - [4. Install and configure Gnome-tweak](#4-install-and-configure-gnome-tweak)
    - [5. Install wezterm](#5-install-wezterm)
      - [5.1. Install AppImageLauncher](#51-install-appimagelauncher)
  - [Windows](#windows)
    - [nvim](#nvim)
  - [Notes](#notes)
  - [To review](#to-review)
  - [To-Do](#to-do)
  - [References](#references)
    - [Git multi user](#git-multi-user)
  - [NEXT](#next) - [Install GNOME Shell Extensions](#install-gnome-shell-extensions) - [Install Brave](#install-brave) - [Install Kanagawa theme](#install-kanagawa-theme) - [Install regolith (should not be installed)](#install-regolith-should-not-be-installed)
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

### 2. Install Homebrew

#### 2.1. Linux requirements

**Note**: If you are on MacOS, skip this step.

[Homebrew requirements for Linux](https://docs.brew.sh/Homebrew-on-Linux#requirements)

```sh
# Linux only
sudo apt-get install build-essential procps curl file git
```

#### 2.2. Installation

```sh
# Ubuntu only
sudo apt-get install build-essential procps curl file git

# Arch Linux
sudo  pacman -S base-devel
```

#### 2.2. Installation

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Warning**: Make sure to follow the steps in next steps displayed after the installation.

### 3. Getting started with chezmoi

```sh
brew install chezmoi
chezmoi init --apply agoodshort
```

### 4. Set zsh as default shell

Note: we need to write manually `zsh` in `/etc/shells` because we install it from homebrew

```sh
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
```

**Note**: After this step you will need to log out and log back in.

### 5. Add the GitHub SSH key to known host

The easiest way is to do it through a pull to test that `agoodshort` profiles works as well.

```
chezmoi cd
git pull
```

### 5. Configure node with nvm

```
nvm install lts/gallium
```

### 6. Create the Coding folder

```sh
mkdir -p ~/Coding/Persona
# If Arch create the below
mkdir -p ~/Coding/AUR
```

## Linux specific

### 1. Install Microsoft Edge

```
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg
sudo apt update
sudo apt install microsoft-edge-stable
```

```sh
cd ~/Coding/AUR
git clone https://aur.archlinux.org/microsoft-edge-stable-bin.git && cd microsoft-edge-stable-bin && makepkg -si
```

### 2. Install docker

```sh
sudo snap install docker
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap disable docker
sudo snap enable docker
sudo chmod 666 /var/run/docker.sock
```

```
# arch, I just did it simple
brew install docker
```

### 3. Basic snaps

```sh
sudo snap install --classic code
sudo snap install --classic slack
sudo snap install zoom-client
```

### 4. Install and configure Gnome-tweak

```sh
sudo apt install gnome-tweaks
```

TODO: needs to be saved

- capslock
- Access to 3rd layer

### 5. Install wezterm

#### 5.1. Install AppImageLauncher

```sh
sudo apt install software-properties-common
sudo add-apt-repository ppa:appimagelauncher-team/stable
sudo apt update
sudo apt install appimagelauncher
```

```sh
brew install wezterm
cd /home/linuxbrew/.linuxbrew/Cellar/wezterm/
# Start wezterm manually and AppImageLauncher will pop-up
```

```sh
# Arch Linux
sudo pacman -Sy wezterm
```

## Windows

### nvim

- requires nvm, node and C
- needed to have the steps below ran:

```sh
scoop install mingw
npm install -g tree-sitter-cli


cd C:\Users\Digital6\AppData\Local\nvim-data\site\pack\packer\start\telescope-fzf-native.nvim
make
```

chezmoi should create (or edit if not existing) the Powershell profile ($PROFILE) and have the line `Invoke-Expression (&starship init powershell)`

https://github.com/twpayne/chezmoi/issues/2273

## Notes

- Scripts under `linux` and `windows` are running based on the OS because of `.chezmoiignore.tmpl`

## To review

```sh
/usr/local/opt/fzf/install --xdg --no-bash --no-fish --no-update-rc --key-bindings --completion
```

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
- [ ] wezterm on macos

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

### Install GNOME Shell Extensions

https://wiki.gnome.org/action/show/Projects/GnomeShellIntegration/Installation#Ubuntu_Linux

```
sudo apt install chrome-gnome-shell
```

### Install Brave

```sh
sudo apt install curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser
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
