### 1. Brew requirements and install

https://docs.brew.sh/Homebrew-on-Linux#requirements

```
sudo apt-get install build-essential procps curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install chezmoi

TODO: make sure to either check on not install git on Linux with Brew
TO THINK: Should I install chezmoi through snap

### 3. Set zsh as default shell

Note: we need to write manually `zsh` in `/etc/shells` because we install it from homebrew

```
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
```

### 4. Gnome-tweak (find out how to install it)

TODO: needs to be saved

- capslock
- Access to 3rd layer

### 5. Configure node with nvm

```
nvm install lts/gallium
```

### 6. Install microsoft edge

```
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg

sudo apt install microsoft-edge-stable
```

### 7. Install docker

```
sudo snap install docker
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap disable docker
sudo snap enable docker
sudo chmod 666 /var/run/docker.sock
```

### 8. Snaps

- brave
- code
- slack

## To review / Optional

### What did not install with brew

Skipping cask alacritty (on Linux) ## Using wezterm
Skipping cask amethyst (on Linux)
Skipping cask font-hack-nerd-font (on Linux) # to remove the tap for linux
Skipping cask google-chrome (on Linux)
Skipping cask karabiner-elements (on Linux)
Skipping cask lepton (on Linux) ## Do I still want to use that
Skipping cask obsidian (on Linux)
Skipping cask postman (on Linux)
Skipping cask slack (on Linux) # Using snap
Skipping cask visual-studio-code (on Linux) # Using snap
Skipping cask xquartz (on Linux)

### font-hack-nerd-font

Not needed, if I go ahead with using only nerd font

```
git clone --filter=blob:none --sparse git@agoodshort.github.com:ryanoasis/nerd-fonts
cd nerd-fonts
git sparse-checkout add patched-fonts/Hack
./install.sh Hack
```

### Notes

- Nice installation steps => https://github.com/tcardonne/dotfiles
- AppImage manager (look GItHUb)
- Flameshot
- Way to automate snap => https://github.com/twpayne/dotfiles/blob/798742d79da7186267083e3c6b37d2250248ba1d/home/.chezmoiscripts/linux/run_onchange_before_install-packages.sh.tmpl
- install wezterm through cask on MacOs
- Add the aws profiles
- SHortcut for ctrl+e to esc
