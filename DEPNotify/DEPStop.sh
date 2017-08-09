#!/bin/bash
#################### Variables ####################
# Unique Launch Agent identifier
org_identifier="com.depnotify"
# Set $4 to "Quitting Message (Default: None)"
quitting_message=""
# Set $5 to "Open Self Service (Default: False)"
open_self_service=""
# Set $6 to "Self Service Path (Default: /Applications/Self Service.app)"
self_service_path=""
# Set $7 to "Ask for Logout (Default: False)"
ask_logout=""
# Set $8 to "Logout Message (Default: Please logout to enable FileVault.)"
logout_message=""
# Set $9 to "Force Logout (Default: False)"
force_logout=""
################## Do Not Modify ##################

# Incase we don't specify anything
if [[ $4 ]]; then
  quitting_message=$4
fi
if [[ $5 ]]; then
  open_self_service=$5
fi
if [[ $6 ]]; then
  self_service_path=$6
elif [[ -z $self_service_path ]]; then
  self_service_path="/Applications/Self Service.app"
fi
if [[ $7 ]]; then
  ask_logout=$7
fi
if [[ $8 ]]; then
  logout_message=$8
elif [[ -z $logout_message ]]; then
  logout_message="Please logout to enable FileVault"
fi
if [[ $9 ]]; then
  force_logout=$9
fi
# Main
if [[ $force_logout ]]; then
  ## Force Logout
  echo "Command: LogoutNow:" >> /var/tmp/depnotify.log
  echo "Command: Quit" >> /var/tmp/depnotify.log
  ## Ask for Logout
elif [[ $ask_logout ]]; then
  echo "Command: WindowStyle: Activate" >> /var/tmp/depnotify.log
  echo "Command: Logout: $logout_message" >> /var/tmp/depnotify.log
else
  ## Quit
  if [[ $quitting_message ]]; then
    ### Quit with message
    echo "Command: WindowStyle: Activate" >> /var/tmp/depnotify.log
    echo "Command: Quit: $quitting_message" >> /var/tmp/depnotify.log
  else
    ### Quit without message
    echo "Command: Quit" >> /var/tmp/depnotify.log
  fi
  ## Open Self Service, if desired
  if [[ $open_self_service ]]; then
    open "$self_service_path"
  fi
fi
/bin/rm -f /Library/LaunchAgents/$org_identifier.plist
exit 0
