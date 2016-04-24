#!/bin/sh

#  create_user_1.2.sh
#
#
#

if [ "$(id -u)" != "0" ]; then
echo "Sorry, you are not root. Please run with sudo!"
exit 1
fi


# === For creating a User we need some input! ===

echo "Enter your desired user name: "
read USERNAME

echo "Enter a full name for this user: "
read FULLNAME

echo "Enter a password for this user: "
read -s PASSWORD

# ====


# A list of groups the user should belong to
# This makes the difference between admin and non-admin users.

echo "Is this an administrative user? (y/n)"
read GROUP_ADD

if [ "$GROUP_ADD" = n ] ; then
   SECONDARY_GROUPS="staff"  # for a non-admin user
elif [ "$GROUP_ADD" = y ] ; then
   SECONDARY_GROUPS="admin _lpadmin _appserveradm _appserverusr" # for an admin user
else
   echo "Please make a selection!"
fi

# ====

# Create a UID that is not currently in use
echo "Creating an unused UID for new user..."

# Find out the next available user ID
MAXID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)
USERID=$((MAXID+1))

# check the OS X Version
OSXVERSION=$(sw_vers -productVersion | awk -F '.' '{print $1 "." $2}')

#if osx 10.10 then run
if [[ "$OSXVERSION" == "10.11" ]]; then
    echo "OS is 10.11"
sysadminctl -addUser $USERNAME -fullName "$FULLNAME" -UID=$USERID -password $PASSWORD

#if osx 10.10 then run

elif [[ "$OSXVERSION" == "10.10" ]]; then
    echo "OS is 10.10"
sysadminctl -addUser $USERNAME -fullName "$FULLNAME" -UID=$USERID -password $PASSWORD

#if osx 10.9 then run

elif [[ "$OSXVERSION" == "10.9" ]]; then

# Create the user account by running dscl
echo "Creating necessary files..."

dscl . -create /Users/$USERNAME
dscl . -create /Users/$USERNAME UserShell /bin/bash
dscl . -create /Users/$USERNAME RealName "$FULLNAME"
dscl . -create /Users/$USERNAME UniqueID "$USERID"
dscl . -create /Users/$USERNAME PrimaryGroupID 20
dscl . -create /Users/$USERNAME NFSHomeDirectory /Users/$USERNAME
dscl . -passwd /Users/$USERNAME $PASSWORD

# Create the home directory
echo "Creating home directory..."
createhomedir -c 2>&1 | grep -v "shell-init"

fi

# Add user to any specified groups
echo "Adding user to specified groups..."

for GROUP in $SECONDARY_GROUPS ; do
dseditgroup -o edit -t user -a $USERNAME $GROUP
done

echo "Created user #$USERID: $USERNAME ($FULLNAME)"

exit 0
