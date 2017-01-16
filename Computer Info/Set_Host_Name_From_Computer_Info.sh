#!/bin/bash
#Read Name from info.plist
name=$(defaults read /Library/ironsystems/info.plist Name)

#Set ComputerName, HostName, LocalHostName
scutil --set ComputerName "$name"
scutil --set LocalHostName "$name"
scutil --set HostName "$name".local

#Create entry in hosts file
echo '127.0.0.1' "$name".local >> /etc/hosts

exit 0
