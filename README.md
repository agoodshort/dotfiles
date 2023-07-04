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
    - [4. Set zsh as default shell](#4-set-zsh-as-default-shell)
    - [5. Add the GitHub SSH key to known host](#5-add-the-github-ssh-key-to-known-host)
    - [5. Configure node with nvm](#5-configure-node-with-nvm)
  - [Linux specific](#linux-specific)
  - [Windows](#windows)
    - [nvim](#nvim)
  - [Notes](#notes)
  - [To review](#to-review)
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

I think this is required with Windows

```sh
/usr/local/opt/fzf/install --xdg --no-bash --no-fish --no-update-rc --key-bindings --completion
```
