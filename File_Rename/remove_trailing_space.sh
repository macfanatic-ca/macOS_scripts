#!/bin/bash
IFS=$'\n'
find . -name '* ' -depth | while read f; do
    mv "$f" "$(dirname "$f")/$(basename "$f" | sed 's/^ *//;s/ *$//')"
done
