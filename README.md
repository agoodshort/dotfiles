# My chezmoi dotfiles

<!-- toc -->

- [Installation](#installation)
    * [1. Homebrew](#1-homebrew)
        + [1.1. Install Homebrew and required tools](#11-install-homebrew-and-required-tools)
        + [1.2. Install `jq` and `lpass`](#12-install-jq-and-lpass)
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

#### 1.2. Install `jq` and `lpass`

```bash
brew install jq lastpass-cli
lpass login --trust USERNAME
```

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
		if [[ -x "$(command -v snap)" ]]; then
			snap install code --classic
		elif [[ -x "$(command -v yay)" ]]; then
			yay -S code --noconfirm
		else
			echo "snap or yay is not installed, cannot install Visual Studio Code"
		fi
	fi

else
	brew install chezmoi
	chezmoi init --apply agoodshort
fi
```

### 4. Install node through nvm

```bash
nvm install lts/gallium
nvm use lts/gallium
```

### 5. Additional steps based on OS

- [Ubuntu](/docs/UBUNUTU.md)
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
- [ ] fix flatpak install and description in [Tools](/docs/TOOLS.md)
- [ ] Work on the format with `{{ end -}}`
- [ ] Mount [secondary drive as home folder](https://www.howtogeek.com/442101/how-to-move-your-linux-home-directory-to-another-hard-drive/)
- [ ] Change `zsh/` to `exact_zsh/`

## References

### Git multi user

- <https://gist.github.com/alejandro-martin/aabe88cf15871121e076f66b65306610>
- <https://stackoverflow.com/a/74832574/13795415>
- <https://gist.github.com/rahularity/86da20fe3858e6b311de068201d279e3>
