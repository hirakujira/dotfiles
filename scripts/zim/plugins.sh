#!/bin/bash

# Replace theme
theme_command=$(eval "echo -e '#Theme\nzmodule romkatv/powerlevel10k\n' >> ~/.zimrc")

# Add Z
z_command=$(eval "echo -e '#Z\nzmodule rupa/z\n' >> ~/.zimrc")

zsh -l -c 'source ~/.zshrc && $theme_command && $z_command && zimfw install'

# Config Powerlevel 10k
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cp $DIR/../../configs/p10k.zsh ~/.p10k.zsh

echo '
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

curl -fsSL -o ~/Library/Fonts/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -fsSL -o ~/Library/Fonts/MesloLGS\ NF\ Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -fsSL -o ~/Library/Fonts/MesloLGS\ NF\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -fsSL -o ~/Library/Fonts/MesloLGS\ NF\ Bold\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> ~/.zshrc