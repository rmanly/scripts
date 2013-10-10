#!/bin/bash

# I used this to modify a bunch of OLD word files that a teacher had not 
# used for years but were now living on a Windows file server without extensions
# they all showed up in finder with generic Unix executable icon etc.

while read -r -d $'\0'; do
    if file "$REPLY" | grep -q "Microsoft Word"; then
        mv "$REPLY" "$REPLY.doc"
    fi
done < <(find . -type f -print0)
