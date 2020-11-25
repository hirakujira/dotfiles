#!/bin/bash

# Replace theme
theme_command=$(eval "sed -i '' 's/zmodule\ steeef/zmodule\ romkatv\/powerlevel10k/g' ~/.zimrc")

# Add Z
z_command=$(eval "echo -e '#Z\nzmodule rupa/z'  >> ~/.zimrc")

zsh -l -c 'source ~/.zshrc && $theme_command && $z_command && zimfw install'

# Config Powerlevel 10k
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cp $DIR/../../configs/p10k.zsh ~/.p10k.zsh

echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> ~/.zshrc