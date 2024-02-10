# my-npm-tools

## Description

This is a collection of dev tools (npm packages) I want installed on my machine.
However, I do not want them installed globally(`npm install -g`) for 2 reasons:

- switching node version using `nvm` globally installed packages are not carried over
- version control my dev tools using chezmoi

## Usage

### Install

Tools are automatically installed and managed through [this chezmoi script](../../../.chezmoiscripts/linux/run_onchange_after_03-my-npm-tools.sh.tmpl).

They are made available globally by [adding them to PATH in the](../../../dot_zshenv.tmpl) `.zshenv` file.

### Node version

The directory contains a `.nvmrc` file that contains the version of node I want to use for these tools.
This allows to use the latest version of node with these dev tools, and keep using an older version as default.

Every time the `cwd` changes, `zsh` will automatically look for a `.nvmrc` file and run `nvm use` for the version of node in the `.nvmrc` file (or `nvm install` if missing).
This is achieved through [this zsh-hook under nvm config](../../../dot_config/zsh/homebrew.zsh).

## Acknowledgements

- [central location for npm packages](https://benfrain.com/adding-to-path-for-a-central-location-for-neovim-npm-tools/)
- [zsh-hook to automatically install node version](https://stackoverflow.com/a/77440721)
