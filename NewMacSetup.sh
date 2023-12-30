#!/bin/zsh

echo "Enabling automatic software updates"
sudo softwareupdate --schedule on

echo "Creating Screenshots directory"
mkdir ~/Screenshots

echo "Creating Developer Directories"
mkdir ~/Developer
cd ~/Developer
mkdir Deceivers
mkdir Enigma
mkdir Personal
mkdir Work
mkdir Scripts
mkdir Themes

#Check if Mac OS command line tools are instlled and install if they aren't
if ! xcode-select -p 1> /dev/null
then
echo "Installing XCode command line tools"
xcode-select --install
fi
echo "XCode command line tools installed!"

#Check if homebrew is installed and install it if it isn't
if ! command -v ports &> /dev/null
then
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
echo "Homebrew installed!"

if [-d "~/.oh-my-zsh"]
then
echo "Installing Oh-My-ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
echo "Oh-My-ZSH installed!"

#Configure Git - This could just be a dot file
echo "Configuring git"
git config --global user.name "Kristopher Zakfeld"
git config --global user.email "kzakfeld@gmail.com"
#TODO: create global gitignore

#TODO: Add function to zsh for java versions
#Create git repo for custom and symlink it?

echo "Tapping tap rooms"
brew tap AdoptOpenJDK/openjdk
brew tap dracula/install
#TODO: Brewfile can probably do this better
echo "Installing Casks"

casks=(
	monitorcontrol
	slack
	discord
	sublime-text
	jetbrains-toolbox
	authy
	macs-fan-control
	arduino
	balenaetcher
	banktivity
	cheatsheet
	handbrake
	keyboardcleantool
	keyboard-maestro
	kicad
	prusaslicer
	sketch
	homebrew/cask-drivers/elgato-stream-deck
	virtualbox
	adoptopenjdk11
	adoptopenjdk8
	iterm2
	autodesk-fusion360
	visual-studio-code
	alfred
	bettertouchtool
	homebrew/cask-versions/firefox-developer-edition
	eloston-chromium
	mysides
	thingsmacsandboxhelper
	tableplus
	minecraft
	multimc
	steam
)

brew cask install ${casks[@]}

echo "Installing Formulae"
formulae=(
	neofetch
	handbrake
	gradle
	maven
	npm
	m-cli
	arduino-cli
	sl
	cmatrix
	cowsay
	fortune
)

brew install ${formulae[@]}

brew cleanup

echo "Installing App Store apps"

apps=(
	904280696 #Things 3
	1091189122 #Bear
	#441258766 #Magnet
	#417375580 #Better Snap Tool
	497799835 #XCode
	937984704 #Amphetamine
	640199958 #Apple Developer
	1107421413 #1Blocker
	1436953057 #Ghostry
	1477385213 #Save to Pocket
	568494494 #Pocket
	1518036000 #Sequel Ace
)

mas install ${apps[@]}

echo "Downloading Themes"
cd ~/Developer/Themes

#Downloand terminal.app theme
git clone https://github.com/dracula/terminal-app.git

#Download iTerm theme
git clone https://github.com/dracula/iterm.git

#Alfred
git clone https://github.com/dracula/alfred

#Sequel Pro
git clone https://github.com/dracula/sequel-pro.git

#ZSH
git clone https://github.com/dracula/zsh.git
#link downloaded ZSH to ZSH themes
ln -s ./zsh/dracula.zsh-theme ~/.oh-my-zsh/custom/themes/dracula.zsh-theme

#Visual Studio Code
git clone https://github.com/dracula/visual-studio-code.git
#ln -s ./visual-studio-code ~/.vscode/extensions/theme-dracula
#simlink wasnt working just copy for now
cp -a ./visual-studio-code ~/.vscode/extensions/theme-dracula
cd ~/.vscode/extensions/theme-dracula
npm install
npm run build

#xcode
git clone https://github.com/dracula/xcode.git
mkdir ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp ./xcode/Dracula.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/ #This should be symlink

#kicad
git clone https://github.com/dracula/kicad.git
cp ./kicad/dracula.json ~/~/Library/Preferences/kicad/6.0/colors/dracula.json

#Symlink this like ZSH is?
#Install vim theme
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
#I might want to clone this into ~/Developer/Themes to be consistent
git clone https://github.com/dracula/vim.git

#Arduino IDE
git clone https://github.com/dracula/arduino-ide.git
./arduino-ide/seup.sh --install

#These can probably com from an already made dot file
touch ~/.vimrc
echo "packadd! dracula" >> ~/.vimrc
echo "syntax enable" >> ~/.vimrc
echo "colorscheme dracula" >> ~/.vimrc

echo "Configuring Applications"
echo "Configuriung Dock"

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

#Remove dock autohide delay
defaults write com.apple.dock autohide-delay -float 0

#Speed up Dock animation
defaults write com.apple.dock autohide-time-modifier -float 0.5

#Show only active applications
defaults write com.apple.dock static-only -bool true

#Set dock small icon size
defaults write com.apple.dock tilesize -int 32

#Set dock large icon size
defaults write com.apple.dock largesize -int 88

#Enable magnification
defaults write com.apple.dock magnification -bool true

#Enable dock autohide
defaults write com.apple.dock autohide -bool true

#Minimize windows to application icon
defaults write com.apple.dock minimize-to-application -bool true

#Don't show open application indicators
defaults write com.apple.dock show-process-indicators -bool false

#Don't show recent applications
defaults write com.apple.dock show-recents -bool false

#Disable launchpad gesture
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false

#Group windows by application in mission control
defaults write com.apple.dock expose-group-apps -bool true

echo "Configuring Finder"

#Disable Desktop
defaults write com.apple.finder CreateDesktop -bool false

#Show hidden files in finder
defaults write com.apple.Finder AppleShowAllFiles -bool true

#Enable text selection in quick look
defaults write com.apple.finder QLEnableTextSelection -bool true

#Don't show removable media on the desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

#Don'e show external drives on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false

#Don't show warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#Remove trash items after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

#Don't warn when emptying trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

#Don't show warning when removing from iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

#Set default search to search the current folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

#Set new finder window to open home folder
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.finder NewWindowTarget -string "PfHm" 

echo "Configuring Siri"

#disable Siri on the lock screen
defaults write com.apple.siri LockscreenEnabled -bool false

echo "Configuring Spaces"

#Each display has it's own spaces
defaults write com.apple.spaces spans-displays -bool false

echo "Configuring Screencapture"

#set save directory to ~/Location
defaults write com.apple.screencapture location ~/Screenshots

#disable thumbnail preview
defaults write com.apple.screencapture show-thumbnail -bool false

echo "Configuring global preferences"

#Set accent color to purple
defaults write .GlobalPreferences AppleAquaColorVariant -int 1
defaults write .GlobalPreferences AppleAccentColor -int 5

#Set Highlight color to purple
defaults write .GlobalPreferences AppleHighlightColor -string "0.968627 0.831373 1.000000 Purple"

#Set dark mode
defaults write .GlobalPreferences AppleInterfaceStyle -string "Dark"

#Jump to spot clicked in scroll bar
defaults write .GlobalPreferences AppleScrollerPagingBehavior -bool true

#Auto hide menubar
defaults write .GlobalPreferences _HIHideMenuBar -bool true

#Keep windows when quiting application
defaults write .GlobalPreferences NSQuitAlwaysKeepsWindows -bool true

#Ask to keep changes when closing documents
defaults write .GlobalPreferences NSCloseAlwaysConfirmsChanges -bool true

#Show all file extensions
defaults write .GlobalPreferences AppleShowAllExtensions -bool true

#Enable preffer tabs always
defaults write .GlobalPreferences AppleWindowTabbingMode -string "always"

#Maximize on window double click
defaults write .GlobalPreferences AppleActionOnDoubleClick -string "Maximize"

#Switch to Space with open window when switching applications
defaults write .GlobalPreferences AppleSpacesSwitchOnActivate -bool true

#set tempeture unit to celsius
defaults write .GlobalPreferences AppleTemperatureUnit -string "Celsius"

#Use 24 hour clock
defaults write .GlobalPreferences AppleICUForce24HourTime -bool true

#Set first day of the week to Monday
defaults write .GlobalPreferences AppleFirstWeekday -dict "gregorian" 2

#Disable Font Smoothing
defaults -currentHost write .GlobalPreferences AppleFontSmoothing -int 0

echo "Configuriung Menubar"

defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.airplay" -bool true
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.battery" -bool true
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.clock" -bool true
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool true
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.airport" -bool true

echo "Configuring Safari"

killall Finder
killall Dock
killall SystemUIServer

echo "Done"

#I might want to download the sublime theme to ~/Developer/Themes to be consistent


# Things I changed (need script for):

# Show safari bars and enable developer mode
# Safari Settings

#vmware fusion player

#golden chaos for btt
#rev hardware client

#most app settings
#lots of apps downloaded from brew/mas
# Amphetamine settings
# Monitor Control settings
# Jetbrains settings
# Better Touch tool preferences
# Prusa slicer settings
# Fusion 360 Settings
# Add theme to iTerm
# Add terminal.app theme
# Enable 1Blocker
# Enable vscode theme
# Enable xcode theme
# Install all jetbrains color schemes
# Install Package manager in sublime and apply dracula theme and gravity theme (gravity one)
# Activate Theme in kicad

#Things that werent straight forward to do:
# Set up finder sidebar
# Set Desktop Background
# Siri Hot keys/ other settings. Cloud based?
# All custom hot keys
# Disc Encryption
# Use apple watch to unlock
# Allow app downloads from identified developers
# Firewall
# Phone forwarding
# Arduino stuff is not currently configured with terminal

# The files in ~/Library/Application Support/com.apple.sharedfilelist hold the settings for the sidebar. Need to either write or find a script to modify.
# Library/containers has a whole buch of other plist files
