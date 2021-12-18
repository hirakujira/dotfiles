#!/bin/bash

echo '
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# You may need to manually set your language environment
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Aliases
alias hosts1="sed -i '\'''\'' '\''s/127\.0\.0\.1/127\.0\.0\.2/g'\'' ~/.ssh/known_hosts"
alias hosts2="sed -i '\'''\'' '\''s/127\.0\.0\.2/127\.0\.0\.1/g'\'' ~/.ssh/known_hosts"
alias python=/usr/local/bin/python3.7
alias pip=/usr/local/bin/pip3

export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Parallel building
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

# Core Utils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Theos Settings
export THEOS=/opt/theos
export THEOS_DEVICE_IP="127.0.0.1 -p 2222"
export SYSROOT=/opt/theos/sdks/iPhoneOS13.7.sdk
export SDKVERSION=13.7

# Make Legacy
makelegacy() {
 export DEVELOPER_DIR=/opt/theos/toolchain/Xcode-9.4.1.app
 targetArchs="armv7 armv7s arm64"
 echo "building ARCHS $targetArchs"
 make ARCHS="$targetArchs"

 echo "checking to see if tweak targets arm64e"
 cat Makefile | grep arm64e
 if [[ $? == 0 ]]; then
  echo "✅ tweak appears to target arm64e"
  targetArchs="armv7 armv7s arm64 arm64e"
  export DEVELOPER_DIR=/Applications/Xcode.app
  echo "DEVELOPER_DIR set to $DEVELOPER_DIR"
  echo "building ARCHS $targetArchs"
  make package ARCHS="$targetArchs"
 else
  echo "❌ tweak does not appear to target arm64e"
  make package ARCHS="$targetArchs"
 fi

 unset DEVELOPER_DIR
 echo "DEVELOPER_DIR unset"
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Loaders
loaddocker() {
  eval $(docker-machine env prl-dev)
}

loadtheos() {
  export DEVELOPER_DIR=/opt/theos/toolchain/Xcode-11.7.app
}

loadnvm() {
  source $(brew --prefix nvm)/nvm.sh
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
