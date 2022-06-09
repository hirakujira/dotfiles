#!/bin/bash

echo '
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

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
' >> ~/.zshrc

echo '
# Loaders
loadtheos() {
  export DEVELOPER_DIR=/opt/theos/toolchain/Xcode-11.7.app
}

loadnvm() {
  source $(brew --prefix nvm)/nvm.sh
}

loaddocker() {
  if [[ -z "${DOCKER_MACHINE_NAME}" ]]; then
    eval $(docker-machine env prl-dev)
    docker-machine ssh prl-dev "sudo bash -c \"echo $'\''search localdomain\nnameserver 8.8.8.8'\'' > /etc/resolv.conf\""
  else
    echo "Docker is loaded"
  fi
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"' >> ~/.zshrc
