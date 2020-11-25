#!/bin/bash

GREEN='\033[0;32m'
NONE='\033[0m' # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
script_dir=$DIR/scripts
config_dir=$DIR/configs

# Allow to run all apps
echo -e "${GREEN}Disable Gatekeeper...${NONE}"
sudo spctl --master-disable

# Check HomeBrew
echo -e "${GREEN}Install Homebrew...${NONE}"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo -e "${GREEN}Homebrew exists, check for updates...${NONE}"
    brew update
fi

# Now we don't need to check update everytime
export HOMEBREW_NO_AUTO_UPDATE=1

#### iTerm2
echo -e "${GREEN}Install iTerm2...${NONE}"
brew cask install iterm2

### zim
echo -e "${GREEN}Install zim...${NONE}"
$script_dir/zim/install.sh

echo -e "${GREEN}Configure zim plugins...${NONE}"
echo -e "${GREEN}Just ignore 'Not installed' and 'Failed to source' error, it's fine.${NONE}"
$script_dir/zim/plugins.sh

### Essential
echo -e "${GREEN}Install Python, nvm and rvm...${NONE}"
brew install python3
brew install nvm
echo -e 'export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zimrc
\curl -sSL https://get.rvm.io | bash -s stable --ruby

### Command-line Utilities
echo -e "${GREEN}Install command-line utilities...${NONE}"
$script_dir/command-line/setup.sh

### iOS development
echo -e "${GREEN}Install iOS development environment...${NONE}"
$script_dir/ios/setup.sh

### Jailbreak development
echo -e "${GREEN}Configure iOS tweak development environment...${NONE}"
$script_dir/jailbreak/setup.sh

### Casks
echo -e "${GREEN}Configure iOS tweak development environment...${NONE}"
$script_dir/casks/install.sh

echo -e "${GREEN}Imporing Xcode themes...${NONE}"
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp $config_dir/*.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/

echo -e "${GREEN}Importing iTerm2 profile...${NONE}"
mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
cp $config_dir/iTerm2.json ~/Library/Application\ Support/iTerm2/DynamicProfiles