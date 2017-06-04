#!/bin/bash
# Disabling FileVaults Auto-login is the best option when utilizing 802.1(1)x's login screen configuration. Although the user must enter their password twice, it ensures internet access is acquired properly. 

sudo defaults write /Library/Preferences/com.apple.loginwindow DisableFDEAutoLogin -bool YES
