#!/bin/bash

echo '
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
alias pip=/usr/local/bin/pip3' >> ~/.zshrc

echo '
function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '\''/System/Library/Frameworks/JavaVM.framework/Home/bin'\''
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
 }

function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

function nvmload () {
	source $(brew --prefix nvm)/nvm.sh
}' >> ~/.zshrc