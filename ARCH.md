# Notes dedicated to Arch Linux

### 9. Make yay/pacman colourful

```bash
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
```

### 10. Install microcode

Install based on the CPU used

Already installed on Ubuntu

```bash
yay -S intel-ucode
# yay -S amd-ucode
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

### Install Kanagawa theme

```bash
yay -S kanagawa-gtk-theme-git
cd /tmp/
git clone git@agoodshort.github.com:refi64/stylepak.git
cd stylepak
./stylepak install-system
./stylepak install-user
```

Use `lxappearance` to review the theme applied.

#### Theming between GTK and QT - to review

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

If needed => https://github.com/candyclaws/Utterly-Kanagawa

### Arch setup

To use laptop with dock, make sure to remove security in BIOS and allow Enhanced USB support. Also read through [this](https://community.frame.work/t/arch-caldigit-ts4-dock-xfce4-trials-tribulations-and-fixes/29117) if issues and [configure Kernel parameters in GRUB](https://forum.manjaro.org/t/how-could-i-edit-a-kernel-parameter/63241/3).

#### Cool things to note

```bash
wf-recorder -f publish_mobile.mp4 -g "$(slurp)"
```

drun `show me the key` to display keystrokes

`yay -Yc` remove unneeded packages

`yay -Qm` list all AUR packages


#### Downgrade

Used to Downgrade previously working packages

```
sudo downgrade code
```