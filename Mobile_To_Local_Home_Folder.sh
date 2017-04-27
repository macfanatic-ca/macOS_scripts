#!/bin/bash

#  Recreate account.sh
#
#  This script is designed to remove a mobile user account and re-create
#  a local account with the same username and the password from user-input.
#  It will also give read/write permissions to the user's home folder.

#Gets the short name of the currently logged in user
loggedInUser=$3

#Get loggedInUser UID
UserUID=`dscl . read /Users/"$loggedInUser" UniqueID | grep UniqueID: | cut -c 11-`

#Exit if UID is under 1000 (local account)
if [[ "$UserUID" -lt 1000 ]]; then
echo "Not a mobile account, exiting"
exit 2
else

#Gets the real name of the currently logged in user
userRealName=`dscl . -read /Users/$loggedInUser | grep RealName: | cut -c11-`
if [[ -z $userRealName ]]; then
userRealName=`dscl . -read /Users/$loggedInUser | awk '/^RealName:/,/^RecordName:/' | sed -n 2p | cut -c 2-`
fi

#Prompts user to enter their login password
loginPassword=`/usr/bin/osascript <<EOT
tell application "System Events"
activate
set myReply to text returned of (display dialog "Please enter your login password." ¬
default answer "" ¬
with title "Macfanatic" ¬
buttons {"Continue."} ¬
default button 1 ¬
with hidden answer)
end tell
EOT`

#Confirm password.
confirmPassword=`/usr/bin/osascript <<EOT
tell application "System Events"
activate
set myReply to text returned of (display dialog "Please confirm your password" ¬
default answer "" ¬
with title "Macfanatic" ¬
buttons {"Continue."} ¬
default button 1 ¬
with hidden answer)
end tell
EOT`

defaultPasswordAttempts=1

#Checks to make sure passwords match, if they don't displays an error and prompts again.
while [ $loginPassword != $confirmPassword ] || [ -z $loginPassword ]; do
`/usr/bin/osascript <<EOT
tell application "System Events"
activate
display dialog "Passwords do not match. Please try again." ¬
with title "Macfanatic" ¬
buttons {"Continue."} ¬
default button 1
end tell
EOT`

loginPassword=`/usr/bin/osascript <<EOT
tell application "System Events"
activate
set myReply to text returned of (display dialog "Please enter your login password." ¬
default answer "" ¬
with title "Macfanatic" ¬
buttons {"Continue."} ¬
default button 1 ¬
with hidden answer)
end tell
EOT`

confirmPassword=`/usr/bin/osascript <<EOT
tell application "System Events"
activate
set myReply to text returned of (display dialog "Please confirm your password" ¬
default answer "" ¬
with title "Macfanatic" ¬
buttons {"Continue."} ¬
default button 1 ¬
with hidden answer)
end tell
EOT`

defaultPasswordAttempts=$((defaultPasswordAttempts+1))

if [[ $defaultPasswordAttempts -ge 5 ]]; then
`/usr/bin/osascript <<EOT
tell application "System Events"
activate
display dialog "You have entered mis-matching passwords five times. Please contact Macfanatic for assistance." ¬
with title "Macfanatic" ¬
buttons {"Continue."} ¬
default button 1
end tell
EOT`
echo "Entered mis-matching passwords too many times."
exit 1
fi

done

#This will delete the currently logged in user
dscl . delete /Users/$loggedInUser

#Gets the current highest user UID
maxid=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)

#New UID for the user
newid=$((maxid+1))

#Creating the new user
dscl . -create /Users/"$loggedInUser"
dscl . -create /Users/"$loggedInUser" UserShell /bin/bash
dscl . -create /Users/"$loggedInUser" RealName "$userRealName"
dscl . -create /Users/"$loggedInUser" UniqueID "$newid"
dscl . -create /Users/"$loggedInUser" PrimaryGroupID 80

#Set the user's password to the one entered prior
dscl . -passwd /Users/"$loggedInUser" "$loginPassword"

#Makes the user an admin
dscl . -append /Groups/admin GroupMembership "$loggedInUser"

#Reset ownership on home directory and append location
chown -R "$loggedInUser":staff /Users/"$loggedInUser"
dscl . -append /Users/"$loggedInUser" NFSHomeDirectory /Users/"$loggedInUser"/

#Delete the user's keychain folder.
rm -Rf /Users/$loggedInUser/Library/Keychains/*

echo "Script successful."

fi

sleep 3

ps -Ajc | grep loginwindow | awk '{print $2}' | xargs kill -9
