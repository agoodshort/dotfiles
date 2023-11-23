#!/bin/bash

echo "----- start: neovim-post-install.sh -----"
python3 -m pip install --user --upgrade pynvim
npm install -g neovim
echo "----- end: neovim-post-install.sh -----"
