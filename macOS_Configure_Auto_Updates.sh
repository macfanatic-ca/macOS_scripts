#!/bin/bash

# locate defaults binary
defaults=$(which defaults)
if [ ! -e "$defaults" ]; then
  echo "defaults binary not found"
  exit 1
fi

# com.apple.commerce
$defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool TRUE
echo "Enabled AutoUpdate"
$defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool TRUE
echo "Enabled AutoUpdateRestartRequired"

# com.apple.SoftwareUpdate
$defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool TRUE
echo "Enabled AutomaticCheckEnabled"
$defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool TRUE
echo "Enabled CriticalUpdateInstall"
$defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool TRUE
echo "Enabled ConfigDataInstall"

exit 0
