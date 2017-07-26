#!/bin/bash
#################### Variables ####################
# Set $4 to "Quitting Message (Default: All Done!)"
quitting_message=""
# Set $5 to "Open Self Service (True || False)"
open_self_service=""
################## Do Not Modify ##################

# Incase we don't specify anything
if [[ $4 ]]; then
  quitting_message=$4
elif [[ -z $quitting_message ]]; then
  quitting_message="All Done!"
fi
if [[ $5 ]]; then
  open_self_service=$5
elif [[ -z $open_self_service ]]; then
  open_self_service="False"
fi
# Quit with message
echo "Command: Quit: $quitting_message" >> /var/tmp/depnotify.log
# Open Self Service, if desired
if [[ $open_self_service == "True" ]]; then
  open /Applications/Self\ Service.app
  exit 0
else
  exit 0
fi
