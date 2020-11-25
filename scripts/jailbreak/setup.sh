#!/bin/bash

brew install dpkg
brew install ldid
brew install libusbmuxd
brew install libirecovery
brew install libimobiledevice

brew tap stek29/homebrew-idevice
brew install ldid2

brew cask install jtool
brew cask install jtool2

brew cask install checkra1n

echo "export THEOS=~/theos" >> ~/.zshrc
git clone --recursive https://github.com/theos/theos.git ~/theos