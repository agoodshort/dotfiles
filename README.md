# My chezmoi dotfiles

<!--toc:start-->

- [My chezmoi dotfiles](#my-chezmoi-dotfiles)
  - [Installation steps](#installation-steps)
    - [1. Homebrew](#1-homebrew)
      - [1.1. Install Homebrew and required tools](#11-install-homebrew-and-required-tools)
      - [1.2. Install `jq` and `lpass`](#12-install-jq-and-lpass)
    - [2. Setup ssh for GitHub](#2-setup-ssh-for-github)
      - [2.1. Create ssh key](#21-create-ssh-key)
      - [2.2. Associate the key with GitHub](#22-associate-the-key-with-github)
      - [2.3. Add the GitHub SSH key to known_host](#23-add-the-github-ssh-key-to-knownhost)
    - [3. Getting started with chezmoi](#3-getting-started-with-chezmoi)
    - [4. Set zsh as default shell](#4-set-zsh-as-default-shell)
    - [5. Configure node with nvm](#5-configure-node-with-nvm)
    - [6. Install packages](#6-install-packages)
    - [7. Install Sway](#7-install-sway)
    - [8. Theme Ubuntu](#8-theme-ubuntu)
  - [To-Do](#to-do)
  - [Notes](#notes)
    - [Ubuntu](#ubuntu)
  - [References](#references) - [Git multi user](#git-multi-user)
  <!--toc:end-->

## Installation steps

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

Install Visual Studio Code before installing `chezmoi` as `brew` will fail to install Visual Studio Code extensions at first run.
TODO: Can we check if vscode is installed on the brewfile template?

```bash
snap install code --classic
brew install chezmoi
chezmoi init --apply agoodshort
```

### 4. Set zsh as default shell

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

### 6. Install packages

```bash
yay -Sy microsoft-edge-stable-bin \
docker \
brave-browser
sudo chmod 666 /var/run/docker.sock
```

### 7. Install Sway

TODO: Find a way to install `mako`
TODO: list cargos

```bash
sudo apt install sway rofi swayidle waybar playerctl kanshi qt5-style-kvantum qt5-style-kvantum-themes
cargo install sworstyle
```

Required with this config and `grimshot` => `grim`, `slurp`, `swaymsg`, `wl-copy`, `jq`, `notify-send`

### 8. Theme Ubuntu

```bash
sudo apt install gnome-tweaks gnome-shell-extensions
```

## To-Do

- [ ] Review bashrc and profile (use only profile)
- [ ] Add Vimium key mappings
- [ ] Set custom/pamac in waybar as a template to work based on the OS
- [ ] Configure Calcurse
- [ ] Create a bootstrap script to install the brew bases and login to lastpass
- [ ] Look at Timeshift and find out how to partition properly
- [ ] Review `zathura` and `qpdf` for pdf and file preview
- [ ] Can we find a cross platform flameshot with wayland
- [ ] Mount [secondary drive as home folder](https://www.howtogeek.com/442101/how-to-move-your-linux-home-directory-to-another-hard-drive/)
- [ ] Review the install of `clamav` with brew

```
To finish installation & run clamav you will need to edit
the example conf files at /home/linuxbrew/.linuxbrew/etc/clamav/

To start clamav now and restart at startup:
  sudo brew services start clamav
Or, if you don't want/need a background service you can just run:
  /home/linuxbrew/.linuxbrew/opt/clamav/sbin/clamd --foreground
```

- [ ] When installing `neovim` we need to use `env TERM=wezterm nvim` - [documentation](https://wezfurlong.org/wezterm/faq.html#how-do-i-enable-undercurl-curly-underlines)

```bash
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile
```

## Notes

- Scripts under `linux` and `windows` are running based on the OS because of `.chezmoiignore.tmpl`

- `wezterm imgcat /path/to/image.png` to display an image

### Ubuntu

Look for a way to install:

- patat
- keylogger like showmethekey
- edge
- Cider

## References

### Git multi user

- https://gist.github.com/alejandro-martin/aabe88cf15871121e076f66b65306610
- https://stackoverflow.com/a/74832574/13795415
- https://gist.github.com/rahularity/86da20fe3858e6b311de068201d279e3
