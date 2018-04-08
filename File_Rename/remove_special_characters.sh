#!/bin/bash
find . -depth -print0 |
while IFS= read -d '' -r file; do
    dir=$(dirname "$file")
    base=$(basename "$file")
    base=${base//[^[:alnum:][:space:]-_,.\'()&\[\]]/_}
    newname="$dir/$base"
    if [[ ! -e $newname ]]; then
        mv "$file" "$newname"
    fi
done
