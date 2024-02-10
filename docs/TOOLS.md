# Tools

<!-- toc -->

- [Chezmoi](#chezmoi)
    * [Scripts overview](#scripts-overview)
- [Rust](#rust)
- [my-npm-tools](#my-npm-tools)
- [Terminal](#terminal)
- [Browsers](#browsers)
    * [Work browser](#work-browser)
    * [Personal browser](#personal-browser)
- [Presentation](#presentation)
    * [To consider](#to-consider)
- [To-Do](#to-do)

<!-- tocstop -->

## Chezmoi

[Chezmoi](https://github.com/twpayne/chezmoi) is the tool that manages the dotfiles.

### Scripts overview

- Scripts under `linux` and `windows` are running based on the OS because of `.chezmoiignore.tmpl`

## Rust

Rust is installed using the [rustup](https://rustup.rs/) tool.

To uninstall :

```sh
rm -rf $RUSTUP_HOME
rm -rf $CARGO_HOME
```

## my-npm-tools

Globally installed npm tools: [my-npm-tools](../home/private_dot_local/private_share/my-npm-tools/README.md)

## Terminal

Default terminal is [WezTerm](https://github.com/wez/wezterm)

Use `wezterm imgcat /path/to/image.png` to display an image

## Browsers

Both personal and work browsers are installed.
Default browser is set based on the machine type (personal or work).

### Work browser

Microsoft Edge is set as the default browser on work machines.

### Personal browser

Brave is the default browser for personal.

## Presentation

- [Slides](https://github.com/maaslalani/slides) - Terminal based presentation tool
- [slidev](https://sli.dev/) - Extremely powerful presentation tool

### To consider

- [ ] <https://github.com/ralexander-phi/marp-to-pages/>

## To-Do

- [ ] Add Vimium key mappings
- [ ] When adding edge application, if it doesn't show in wofi, use the create shortcut from edge settings
- [ ] Finishing describing the chezmoi scripts
- [ ] Review the install of `clamav` with brew

```
To finish installation & run clamav you will need to edit
the example conf files at /home/linuxbrew/.linuxbrew/etc/clamav/

To start clamav now and restart at startup:
  sudo brew services start clamav
Or, if you don't want/need a background service you can just run:
  /home/linuxbrew/.linuxbrew/opt/clamav/sbin/clamd --foreground
```
