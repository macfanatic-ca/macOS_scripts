#!/bin/bash
# Look for and remove Daylite 3
if [ -e /Applications/Daylite\ 3/ ]; then
    echo "Daylite 3 found"
    rm -rf /Applications/Daylite\ 3/
        if [ "$?" == 0 ]; then
            echo "Daylite 3 removed"
        fi
else
echo "Daylite 3 not found"
fi
# Look for and remove Daylite 4 & 5
if [ -e /Applications/Daylite.app ]; then
dayliteVersion=`defaults read /Applications/Daylite.app/Contents/Info.plist CFBundleShortVersionString`
    if [[ "$dayliteVersion" == 4.* ]] || [[ "$dayliteVersion" == 5.* ]]; then
        echo "Daylite 4 or 5 found"
        rm -rf /Applications/Daylite.app
            if [ "$?" == 0 ]; then
                echo "Daylite 4 or 5 removed"
            fi
    elif [[ "$dayliteVersion" == 6.* ]]; then
        echo "Daylite 6 found"
    fi
else
echo "Daylite 4, 5, or 6 not found"
fi
exit 0
