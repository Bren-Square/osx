#!/bin/bash
# osx-bootstrap.sh - A setup script because installing shit by hand is stupid
# July 5th, 2018
# The fact that OSX doesn't have a native installer like YUM is disturbing. 
# Just putting that out there. 

# Define required packages
PACK=(
  ack
  autoconf
  automake
  ffmpeg
  gettext
  git
  graphviz
  hub
  imagemagick
  jq
  libjpeg
  libmemcached 
  lynx
  markdown
  memcached
  mercurial
  mysql@5.6
  npm
  pkg-config
  postgresql
  python
  python3
  pypy
  redis
  rename
  ssh-copy-id
  terminal-notifier
  the_silver_searcher
  tmux
  tree
  vim
  wget
)

# Define Casks
CASK=(
  1password
  backblaze
  box-sync
  firefox
  google-chrome
  gpgtools
  macvim
  microsoft-office
  slack
  vscode
)

# System fonts that I typically install
FONT=(
  font-inconsolidata
  font-roboto
  font-clear-sans
)

# Python packages that I use. 
PYPA=(
  ipython
  virtualenv
  virtualenvwrapper
)

# Ruby Gems
RGEM=(
    bundler
)

#####################
### ACTUAL SCRIPT ###
#####################

echo "Starting bootstrap"

# Check for Homebrew, install if we don't have it
if test ! "$(command -v brew)"; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

##############################
### INSTALL ALL THE THINGS ###
##############################

brew update
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names
brew install gnu-grep --with-default-names
brew install findutils
brew install bash
brew install "${PACK[@]}"
brew cleanup
brew install caskroom/cask/brew-cask
brew cask install "${CASK[@]}"
brew tap caskroom/fonts
brew cask install "${FONT[@]}"
sudo pip install "${PYPA[@]}"
sudo gem install "${RGEM[@]}"
npm install marked -g

echo "Bootstrap complete"
sleep 3

##################
### OSX CONFIG ###
##################

echo "Configuring OSX..."

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Bootstrap complete"
