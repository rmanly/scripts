#!/bin/bash

# remove unassociated apps
/bin/rm -rf /Applications/Garageband.app
/bin/rm -rf /Applications/Keynote.app
/bin/rm -rf /Applications/Numbers.app
/bin/rm -rf /Applications/Pages.app
/bin/rm -rf /Applications/iMovie.app
/bin/rm -rf /Applications/iPhoto.app

# remove MAS adoption file
/bin/rm /var/db/.MASManifest
