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

echo '
# Theos Settings
export THEOS=~/theos
export THEOS_DEVICE_IP="127.0.0.1 -p 2222"
export SYSROOT=~/theos/sdks/iPhoneOS10.3.sdk
export SDKVERSION=10.3' >> ~/.zshrc

echo '
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
}' >> ~/.zshrc

git clone --recursive https://github.com/theos/theos.git ~/theos