# My chezmoi dotfiles

<!--toc:start-->

- [My chezmoi dotfiles](#my-chezmoi-dotfiles)
  - [To get started](#to-get-started)
    - [1. Setup ssh for GitHub](#1-setup-ssh-for-github)
      - [1.1. Create ssh key](#11-create-ssh-key)
      - [1.2. Associate the key with GitHub](#12-associate-the-key-with-github)
    - [2. Install Homebrew](#2-install-homebrew)
    - [3. Getting started with chezmoi](#3-getting-started-with-chezmoi)
    - [4. Set zsh as default shell](#4-set-zsh-as-default-shell)
    - [5. Configure node with nvm](#5-configure-node-with-nvm)
  - [Linux specific](#linux-specific)
    - [1. Install Microsoft Edge](#1-install-microsoft-edge)
    - [2. Install docker](#2-install-docker)
    - [3. Basic snaps](#3-basic-snaps)
  - [Scripts](#scripts)
  - [Windows](#windows)
    - [nvim](#nvim)
  - [Git config resources](#git-config-resources)
  - [To review](#to-review)
  - [To-Do](#to-do)
  <!--toc:end-->

I will make this a little more readable later, for now here is the command I wanted to save somewhere.

## To get started

### 1. Setup ssh for GitHub

#### 1.1. Create ssh key

```sh
ssh-keygen -t ed25519 -C "adrien.goodshort@gmail.com" -f "github-agoodshort"
pbcopy < ~/.ssh/github-agoodshort.pub # copy public key to clipboard
```

#### 1.2. Associate the key with GitHub

Add the copied key in your [GitHub Profile SSH keys](https://github.com/settings/keys).

### 2. Install Homebrew

[Homebrew requirements for Linux](https://docs.brew.sh/Homebrew-on-Linux#requirements)

```sh
# sudo apt-get install build-essential procps curl file git # Linux only
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

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

### 5. Configure node with nvm

```
nvm install lts/gallium
```

## Linux specific

### 1. Install Microsoft Edge

```
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg

sudo apt install microsoft-edge-stable
```

### 2. Install docker

```
sudo snap install docker
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap disable docker
sudo snap enable docker
sudo chmod 666 /var/run/docker.sock
```

### 3. Basic snaps

```
sudo snap install --classic code
sudo snap install --classic brave
sudo snap install --classic slack
```

### 4. Install and configure Gnome-tweak
TODO: needs to be saved

- capslock
- Access to 3rd layer

## Windows

### nvim

- requires nvm, node and C
- needed to have the steps below ran:

```
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

```
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

## References

### Git multi user

- https://gist.github.com/alejandro-martin/aabe88cf15871121e076f66b65306610
- https://stackoverflow.com/a/74832574/13795415
- https://gist.github.com/rahularity/86da20fe3858e6b311de068201d279e3
