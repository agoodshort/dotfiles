# Notes dedicated to Arch Linux

<!-- toc -->

- [Installation](#installation)
    * [1. Install yay (AUR helper)](#1-install-yay-aur-helper)
    * [2. Theming between GTK and QT - to review](#2-theming-between-gtk-and-qt---to-review)
    * [3. Configure dock](#3-configure-dock)
- [How-to](#how-to)
    * [Screen recording](#screen-recording)
    * [AUR](#aur)
    * [Downgrade](#downgrade)

<!-- tocstop -->

## Installation

### 1. Install yay (AUR helper)

```bash
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

yay -S catppuccin-gtk-theme-macchiato
```

### 2. Theming between GTK and QT - to review

For Kvantum => <https://github.com/catppuccin/Kvantum>

Use `lxappearance` to review the theme applied.

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

If needed => <https://github.com/candyclaws/Utterly-Kanagawa>

### 3. Configure dock

To use laptop with dock, make sure to remove security in BIOS and allow Enhanced USB support. Also read through [this](https://community.frame.work/t/arch-caldigit-ts4-dock-xfce4-trials-tribulations-and-fixes/29117) if issues and [configure Kernel parameters in GRUB](https://forum.manjaro.org/t/how-could-i-edit-a-kernel-parameter/63241/3).

## How-to

### Screen recording

```bash
wf-recorder -f screen_recording.mp4 -g "$(slurp)"
```

drun `show me the key` to display keystrokes

### AUR

- `yay -Yc` remove unneeded packages
- `yay -Qm` list all AUR packages

### Downgrade

Used to Downgrade previously working packages

```
sudo downgrade code
```
