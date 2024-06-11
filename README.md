# My chezmoi dotfiles

<!-- toc -->

- [Installation](#installation)
    * [1. Homebrew](#1-homebrew)
        + [1.1. Install Homebrew and required tools](#11-install-homebrew-and-required-tools)
        + [1.2. Install dependencies](#12-install-dependencies)
    * [1.3. Install kvantum theme](#13-install-kvantum-theme)
    * [2. Setup ssh for GitHub](#2-setup-ssh-for-github)
        + [2.1. Create ssh key](#21-create-ssh-key)
        + [2.2. Associate the key with GitHub](#22-associate-the-key-with-github)
        + [2.3. Add the GitHub SSH key to known_host](#23-add-the-github-ssh-key-to-known_host)
    * [3. Getting started with chezmoi](#3-getting-started-with-chezmoi)
    * [4. Install node through nvm](#4-install-node-through-nvm)
    * [5. Additional steps based on OS](#5-additional-steps-based-on-os)
- [Tools](#tools)
- [To-Do](#to-do)
- [References](#references)
    * [Git multi user](#git-multi-user)

<!-- tocstop -->

## Installation

### 1. Homebrew

#### 1.1. Install Homebrew and required tools

Install the [Homebrew dependencies for Linux](https://docs.brew.sh/Homebrew-on-Linux#requirements)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Warning**: Make sure to follow the steps in "next steps" displayed after the installation.

#### 1.2. Install dependencies

```bash
brew install jq lastpass-cli nvm
lpass login --trust USERNAME

mkdir -p ~/Coding/Personal

if [[ ! $OSTYPE == 'darwin'* ]]; then
	sudo pacman -S openssh wl-clipboard flatpak zsh --noconfirm

	if [[ ! -x "$(command -v yay)" ]]; then
		cd ~/Coding/Personal
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ../
		rm -rf yay
		yay -Y --gendb
		yay -Syu --devel
		yay -Y --devel --save
	fi

	# Make yay/pacman colourful
	sudo sed -i 's/^#Color/Color/' /etc/pacman.conf

	yay -S akm --noconfirm        # great tool for kernel selection
	yay -S xmlstarlet --noconfirm # used by apdatifier
	yay -S docker docker-compose --noconfirm
	systemctl enable --now docker
	sudo usermod -aG docker $USER
	newgrp docker

	# Sway dependencies
	yay -S sway rofi swayidle waybar playerctl kanshi light swaync swaybg swaylock kvantum waybar-updates bluetuith swappy cliphist inotify-tools catppuccin-gtk-theme-macchiato ttf-roboto-mono-nerd ttf-roboto-mono
	brew install calcurse
fi
```

### 1.3. Install kvantum theme

```bash
cd ~/Coding/Personal
git clone https://github.com/catppuccin/Kvantum.git
kvantummanager
```

In `kvantummanager` select the theme folder `Catppuccin-Macchiato-blue` and install it. Then set it as the default.

### 2. Setup ssh for GitHub

#### 2.1. Create ssh key

```bash
mkdir ~/.ssh && cd $_
ssh-keygen -t ed25519 -C "adrien.goodshort@gmail.com" -f "github-agoodshort"

if [[ $OSTYPE == 'darwin'* ]]; then
	pbcopy <~/.ssh/github-agoodshort.pub # copy public key to clipboard
else
	wl-copy <~/.ssh/github-agoodshort.pub # https://neovim.io/doc/user/provider.html#provider-clipboard
fi
```

#### 2.2. Associate the key with GitHub

Add the copied key in your [GitHub Profile SSH keys](https://github.com/settings/keys).

#### 2.3. Add the GitHub SSH key to known_host

```bash
curl --silent https://api.github.com/meta |
	jq --raw-output '"github.com "+.ssh_keys[]' >>~/.ssh/known_hosts
```

### 3. Getting started with chezmoi

Install Visual Studio Code before installing `chezmoi` as `brew` will fail to install Visual Studio Code extensions during the first run.

```bash
if [[ ! -x "$(command -v code)" ]]; then

	if [[ $OSTYPE == 'darwin'* ]]; then
		brew install --cask visual-studio-code
	else
		sudo pacman -S code --noconfirm
	fi
fi

brew install chezmoi
chezmoi init --apply agoodshort
```

### 4. Install node through nvm

```bash
nvm install lts/gallium
nvm use lts/gallium
```

### 5. Additional steps based on OS

- [Windows](/docs/WINDOWS.md)
- [MacOS](/docs/MACOS.md)
- [Arch](/docs/ARCH.md)

## Tools

List of tools used is available in [Tools](/docs/TOOLS.md).

## To-Do

- [ ] Set custom/pamac-yay in waybar as a template to work based on the OS
- [ ] List cargo
- [ ] Configure Calcurse
- [ ] Create a bootstrap script to install the brew bases and login to lastpass
- [ ] Look at Timeshift and find out how to partition properly
- [ ] Review `zathura` and `qpdf` for pdf and file preview
- [ ] Work on the format with `{{ end -}}`
- [ ] Mount [secondary drive as home folder](https://www.howtogeek.com/442101/how-to-move-your-linux-home-directory-to-another-hard-drive/)
- [ ] Change `zsh/` to `exact_zsh/`

![image](https://github.com/agoodshort/dotfiles/assets/33832653/f9eaa504-ca26-4b2b-bd64-a3a4da49b793)

![image](https://github.com/agoodshort/dotfiles/assets/33832653/c0a70690-0ea0-4842-890a-8b85a028b6f6)

![image](https://github.com/agoodshort/dotfiles/assets/33832653/9c983bb1-1872-4e86-b08b-51ff29c18a18)

## References

### Git multi user

- <https://gist.github.com/alejandro-martin/aabe88cf15871121e076f66b65306610>
- <https://stackoverflow.com/a/74832574/13795415>
- <https://gist.github.com/rahularity/86da20fe3858e6b311de068201d279e3>
