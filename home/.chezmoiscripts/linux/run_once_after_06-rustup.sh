#!/bin/bash

echo "----- start: rustup.sh -----"

if [[ -f "$HOMEBREW_PREFIX/bin/rustup-init" ]]; then
    echo "Installing rustup..."
    rustup-init --no-modify-path -y
else
    echo "No rustup-init found, impossible to install rustup"
fi

echo "----- end: rustup.sh -----"
