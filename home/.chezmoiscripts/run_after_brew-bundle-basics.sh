#!/bin/bash

if [[ -e $HOME/.config/homebrew/Brewfile_Basics ]]; then
    echo "Installing  homebrew basics..."
    brew bundle --file $HOME/.config/homebrew/Brewfile_Basics
    echo "Done installing homebrew basics basics"
else
    echo "HOMEBREW_BUNDLE_FILE isn't set, impossible to generate Brewfile"
fi
echo "-------------------------------"
