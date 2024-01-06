#!/bin/bash

echo "----- start: 04-neovim-post-install.sh -----"
echo "Installing pynvim..."
python3 -m pip install --user --upgrade pynvim
echo "Done installing pynvim"

# https://wezfurlong.org/wezterm/faq.html#how-do-i-enable-undercurl-curly-underlines
# Works with the zsh function nvim
echo "Installing terminfo file for undercurl..."
tempfile=$(mktemp) &&
	curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo &&
	tic -x -o ~/.terminfo $tempfile &&
	rm $tempfile
echo "Done installing terminfo file for undercurl"
echo "----- end: 04-neovim-post-install.sh -----"
