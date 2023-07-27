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
    - [5. Configure node with nvm](#5-configure-node-with-nvm)
    - [6. Install yay (AUR helper) and create the personal directory](#6-install-yay-aur-helper-and-create-the-personal-directory)
    - [7. Install packages](#7-install-packages)
    - [8 Neovim post-install](#8-neovim-post-install)
  - [To-Do](#to-do)
  - [References](#references)
    - [Git multi user](#git-multi-user)
    - [Install Kanagawa theme](#install-kanagawa-theme)
  - [Notes](#notes)
  - [Windows](#windows) - [neovim](#neovim)
  <!--toc:end-->

I will make this a little more readable later, for now here is the command I wanted to save somewhere.

## To get started

### 1. Setup ssh for GitHub

#### 1.1. Create ssh key

```bash
mkdir ~/.ssh && cd $_
ssh-keygen -t ed25519 -C "adrien.goodshort@gmail.com" -f "github-agoodshort"
if [[ $OSTYPE == 'darwin'* ]]; then
    pbcopy < ~/.ssh/github-agoodshort.pub # copy public key to clipboard
else
    wl-copy < ~/.ssh/github-agoodshort.pub # https://neovim.io/doc/user/provider.html#provider-clipboard
fi

```

#### 1.2. Associate the key with GitHub

Add the copied key in your [GitHub Profile SSH keys](https://github.com/settings/keys).

#### 1.3. Add the GitHub SSH key to known_host

```bash
curl --silent https://api.github.com/meta \
  | jq --raw-output '"github.com "+.ssh_keys[]' >> ~/.ssh/known_hosts
```

### 2. Install Homebrew

[Homebrew requirements for Linux](https://docs.brew.sh/Homebrew-on-Linux#requirements)

```bash
sudo  pacman -S base-devel # Arch Linux only
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Warning**: Make sure to follow the steps in "next steps" displayed after the installation.

### 3. Getting started with chezmoi

```bash
brew install chezmoi
chezmoi init --apply agoodshort
```

### 4. Set zsh as default shell

Default on Arch linux.

TODO: do not install zsh with brew if on arch

Note: we need to write manually `zsh` in `/etc/shells` because we install it from homebrew

```bash
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
```

**Note**: After this step you will need to log out and log back in.

### 5. Configure node with nvm

```
nvm install lts/gallium
```

### 6. Install yay (AUR helper) and create the personal directory

```bash
mkdir -p ~/Coding/Personal && cd $_
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ../
rm -rf yay
yay -Y --gendb
yay -Syu --devel
yay -Y --devel --save
```

### 7. Install packages

```bash
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

### 8. Neovim post-install

```bash
python3 -m pip install --user --upgrade pynvim
npm install -g neovim
```

## To-Do

- [ ] Review bashrc and profile (use only profile)
- [ ] Review required `brew casks/formula` to run the zsh or bash properly
- [ ] Review vim XDG location
- [ ] Add `pbcopy` on Linux => https://ostechnix.com/how-to-use-pbcopy-and-pbpaste-commands-on-linux/
- [ ] Mission Control is left by default as karabiner keymaps are built on top of it
- [ ] List desktop to be assigned on MacOS and display (with the right click on icon)
- [ ] should we use a template for Neovim dashboard to point to `{{ .chezmoi.homeDir }}` or is XDG_CONFIG_HOME fine? => windows issue
- [ ] Install docker engine through brew in MacOS?
- [ ] Create a run-once to install the brew basics and login to lastpass

## References

### Git multi user

- https://gist.github.com/alejandro-martin/aabe88cf15871121e076f66b65306610
- https://stackoverflow.com/a/74832574/13795415
- https://gist.github.com/rahularity/86da20fe3858e6b311de068201d279e3

### Install Kanagawa theme

```bash
cd ~/Coding/Personal/
git clone git@agoodshort.github.com:Fausto-Korpsvart/Kanagawa-GKT-Theme.git
cd Kanagawa-GKT-Theme
cp -r themes/Kanagawa-B ~/.themes
cp -r themes/Kanagawa-B/gtk-4.0/* ~/.config/gtk-4.0/
```

## Notes

- Scripts under `linux` and `windows` are running based on the OS because of `.chezmoiignore.tmpl`

## Windows

### Neovim

- requires nvm, node and C
- needed to have the steps below ran:

```bash
scoop install mingw
npm install -g tree-sitter-cli


cd C:\Users\Digital6\AppData\Local\nvim-data\site\pack\packer\start\telescope-fzf-native.nvim
make
```

chezmoi should create (or edit if not existing) the Powershell profile ($PROFILE) and have the line `Invoke-Expression (&starship init powershell)`

https://github.com/twpayne/chezmoi/issues/2273

## Cool things to note

```bash
wf-recorder -f publish_mobile.mp4 -g "$(slurp)"
```

`show me the key` to display keystroes
