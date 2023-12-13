#!/bin/bash

echo "----- start: zsh.sh -----"
if [[ $SHELL != *"zsh"* ]]; then
    echo "Changing shell to zsh..."
    if  ! grep -q "$(which zsh)" /etc/shells; then
        sudo sh -c "echo $(which zsh) >> /etc/shells"
    fi
    chsh -s "$(which zsh)"
    echo "/!\ Default shell changed to zsh /!\ "
    echo "/!\ Log out and log back in to use zsh /!\ "
else
    echo "zsh is already the default shell"
fi
echo "----- end: zsh.sh -----"