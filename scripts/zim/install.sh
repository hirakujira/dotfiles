#!/bin/bash

if [ ! -d ~/.zim ]; then
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
fi
