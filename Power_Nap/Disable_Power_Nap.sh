#!/bin/bash

#Disable PowerName

pwrnap=$(pmset -g | grep darkwakes | awk '{ print $2 }'
    if [ "$pwrnap" == "0" ]; then
        echo "PowerNap already disabled"
    else
        pmset -a darkwakes 0
        echo "PowerNap now disabled"
    fi
