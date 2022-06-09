#!/bin/bash

GREEN='\033[1;32m'
RED='\033[1;31m'
NONE='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
script_dir=$DIR/scripts
config_dir=$DIR/configs

# Allow to run all apps
echo -e "${GREEN}[dotfiles] Disable Gatekeeper...${NONE}"
sudo spctl --master-disable

# Check HomeBrew
echo -e "${GREEN}[dotfiles] Install Homebrew...${NONE}"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo -e "${RED}[dotfiles] Please install Homebrew first!${NONE}"
    exit 1
else
    echo -e "${GREEN}[dotfiles] Homebrew exists, check for updates...${NONE}"
    brew update
fi

# Now we don't need to check update everytime
export HOMEBREW_NO_AUTO_UPDATE=1

#### iTerm2
echo -e "${GREEN}[dotfiles] Install iTerm2...${NONE}"
brew install iterm2

### zim
echo -e "${GREEN}[dotfiles] Install zim...${NONE}"
$script_dir/zim/install.sh

echo -e "${GREEN}[dotfiles] Configure zim plugins...${NONE}"
echo -e "${RED}[dotfiles] !!!Just ignore 'Not installed' and 'Failed to source' error, it's fine.!!!${NONE}"
$script_dir/zim/plugins.sh
echo -e "${RED}[dotfiles] !!!Just ignore 'Not installed' and 'Failed to source' error, it's fine.!!!${NONE}"

echo -e "${GREEN}Configure zshrc...${NONE}"
$script_dir/zim/zshrc.sh

### Essential
echo -e "${GREEN}[dotfiles] Install Python, nvm and rvm...${NONE}"
brew install python3
brew install nvm
echo -e 'export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zimrc
\curl -sSL https://get.rvm.io | bash -s stable --ruby

### Command-line Utilities
echo -e "${GREEN}[dotfiles] Install command-line utilities...${NONE}"
$script_dir/cli-tools/setup.sh

### iOS development
echo -e "${GREEN}[dotfiles] Install iOS development environment...${NONE}"
$script_dir/ios/setup.sh

### Jailbreak development
echo -e "${GREEN}[dotfiles] Configure iOS tweak development environment...${NONE}"
$script_dir/jailbreak/setup.sh

### Casks
echo -e "${GREEN}[dotfiles] Install apps...${NONE}"
$script_dir/casks/install.sh

echo -e "${GREEN}[dotfiles] Import Xcode themes...${NONE}"
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp $config_dir/*.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/

echo -e "${GREEN}[dotfiles] Import iTerm2 profile...${NONE}"
cp -f $config_dir/com.googlecode.iterm2.plist ~/Library/Preferences

echo -e "${GREEN}[dotfiles] Import karabiner settings...${NONE}"
mkdir -p ~/.config
cp -R $config_dir/karabiner ~/.config

echo -e "${GREEN}[dotfiles] Import git global settings...${NONE}"
cp -f $config_dir/git/gitconfig ~/.gitconfig
cp -f $config_dir/git/gitignore_global ~/.gitignore_global

echo -e "${GREEN}[dotfiles] Fix 1Password bug...${NONE}"
mkdir -p ~/Library/Application\ Support/Google/Chrome

echo -e "${GREEN}[dotfiles] Config misc settings...${NONE}"
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos
$script_dir/config.sh
