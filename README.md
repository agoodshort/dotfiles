# My chezmoi dotfiles

<!--toc:start-->
- [My chezmoi dotfiles](#my-chezmoi-dotfiles)
    - [1.1. Install Homebrew and required tools](#11-install-homebrew-and-required-tools)
    - [1.2. Install `jq` and `lpass`](#12-install-jq-and-lpass)
    - [2. Setup ssh for GitHub](#2-setup-ssh-for-github)
      - [2.1. Create ssh key](#21-create-ssh-key)
      - [2.2. Associate the key with GitHub](#22-associate-the-key-with-github)
      - [2.3. Add the GitHub SSH key to known_host](#23-add-the-github-ssh-key-to-knownhost)
    - [3. Getting started with chezmoi](#3-getting-started-with-chezmoi)
    - [4. Set zsh as default shell](#4-set-zsh-as-default-shell)
    - [5. Configure node with nvm](#5-configure-node-with-nvm)
    - [6. Install yay (AUR helper) and create the personal directory](#6-install-yay-aur-helper-and-create-the-personal-directory)
    - [7. Install packages](#7-install-packages)
    - [8. Neovim post-install](#8-neovim-post-install)
    - [9. Install Snapcraft](#9-install-snapcraft)
    - [10. Make yay/pacman colourful](#10-make-yaypacman-colourful)
    - [11. Install microcode](#11-install-microcode)
  - [To-Do](#to-do)
  - [References](#references)
    - [Git multi user](#git-multi-user)
    - [Install Kanagawa theme](#install-kanagawa-theme)
  - [Notes](#notes)
    - [Windows](#windows)
      - [Neovim](#neovim)
    - [Arch setup](#arch-setup)
      - [Cool things to note](#cool-things-to-note)
      - [Theme](#theme)
      - [Downgrade](#downgrade)
<!--toc:end-->

### 1.1. Install Homebrew and required tools

[Homebrew requirements for Linux](https://docs.brew.sh/Homebrew-on-Linux#requirements)

```bash
if [[ $OSTYPE != 'darwin'* ]];
  sudo  pacman -S base-devel # At least for Arch Linux
fi
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Warning**: Make sure to follow the steps in "next steps" displayed after the installation.

### 1.2. Install `jq` and `lpass`

```bash
brew install jq lastpass-cli
lpass login USERNAME
```

### 2. Setup ssh for GitHub

#### 2.1. Create ssh key

```bash
mkdir ~/.ssh && cd $_
ssh-keygen -t ed25519 -C "adrien.goodshort@gmail.com" -f "github-agoodshort"
if [[ $OSTYPE == 'darwin'* ]]; then
    pbcopy < ~/.ssh/github-agoodshort.pub # copy public key to clipboard
else
    wl-copy < ~/.ssh/github-agoodshort.pub # https://neovim.io/doc/user/provider.html#provider-clipboard
fi

```

#### 2.2. Associate the key with GitHub

Add the copied key in your [GitHub Profile SSH keys](https://github.com/settings/keys).

#### 2.3. Add the GitHub SSH key to known_host

```bash
curl --silent https://api.github.com/meta \
  | jq --raw-output '"github.com "+.ssh_keys[]' >> ~/.ssh/known_hosts
```

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
deskreen-bin \
github-cli
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

### 9. Install Snapcraft

```bash
yay snapd
sudo systemctl enable --now snapd.socket
```

### 10. Make yay/pacman colourful

```bash
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
```

### 11. Install microcode

Install based on the CPU used

```bash
yay -S intel-ucode
# yay -S amd-ucode
```

It is recommended to restart the machine after installation.

## To-Do

- [ ] Review bashrc and profile (use only profile)
- [ ] Review required `brew casks/formula` to run the zsh or bash properly
- [ ] Mission Control is left by default as karabiner keymaps are built on top of it
- [ ] List desktop to be assigned on MacOS and display (with the right click on icon)
- [ ] should we use a template for Neovim dashboard to point to `{{ .chezmoi.homeDir }}` or is XDG_CONFIG_HOME fine? => windows issue
- [ ] Install docker engine through brew in MacOS?
- [ ] Create a run-once to install the brew basics and login to lastpass
- [ ] Sync Sway calendar
- [ ] Add Vimium key mappings
- [ ] Configure Calcurse
- [ ] Look at Timeshift and find out how to partition properly
- [ ] `yay -Qm` to list all packages from AUR
- [ ] Neovim `initial_mode = "normal"` does not work for extensions git_diffs
- [ ] Install homebrew first, because `jq` is not available by default on macos
- [ ] Review the `base-devel` step at the beggining to match all distros

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

### Windows

#### Neovim

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

### Arch setup

To use laptop with dock, make sure to remove security in BIOS and allow Enhanced USB support. Also read through [this](https://community.frame.work/t/arch-caldigit-ts4-dock-xfce4-trials-tribulations-and-fixes/29117) if issues and [configure Kernel parameters in GRUB](https://forum.manjaro.org/t/how-could-i-edit-a-kernel-parameter/63241/3).

#### Cool things to note

```bash
wf-recorder -f publish_mobile.mp4 -g "$(slurp)"
```

drun `show me the key` to display keystrokes

`yay -Yc` remove unneeded packages

#### Theme

There are 2 styling method => gtk and Qt

```
lxappearance
qt5ct
qt6ct
```

[For theme matching](https://wiki.archlinux.org/title/Uniform_look_for_Qt_and_GTK_applications#QGtkStyle)

```
yay -S kanagawa-gtk-theme-git qt6gtk2 qt5-styleplugins
```

https://github.com/candyclaws/Utterly-Kanagawa

#### Downgrade

Used to Downgrade previously working packages

```
sudo downgrade code
```
