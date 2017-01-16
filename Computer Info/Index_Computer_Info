#!/bin/bash
#Grab info from System_Profiler
model=$(system_profiler SPHardwareDataType | grep "Model Identifier" | awk '{print $3}')
serial=$(system_profiler SPHardwareDataType | awk '/Serial\ Number\ \(system\)/ {print $NF}')

#Define Name prefix based on model
if [[ "$model" = MacBookPro* ]]; then
prefix="MBP-"
elif [[ "$model" = MacBookAir* ]]; then
prefix="MBA-"
elif [[ "$model" = MacPro* ]]; then
prefix="MP-"
elif [[ "$model" = iMac* ]]; then
prefix="iM-"
elif [[ "$model" = MacBook* ]]; then
prefix="MB-"
elif [[ "$model" = MacMini* ]]; then
prefix="MM-"
else
prefix="M-"
fi

#Create and write to info.plist
touch /Library/ironsystems/info.plist
defaults write /Library/ironsystems/info.plist Model -string "$model"
defaults write /Library/ironsystems/info.plist SerialNumber -string "$serial"
defaults write /Library/ironsystems/info.plist Name -string "$prefix""$serial"

exit 0
