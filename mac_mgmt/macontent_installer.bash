#!/bin/bash

# Full credit to Gabe Shackney here:
# https://jamfnation.jamfsoftware.com/discussion.html?id=14594

freeSpace=$(df -k /tmp | tail -1 | awk '{print $4} ')

if (("$freeSpace" > "16000000"))
then
sleep 5
/usr/sbin/installer -pkg /private/tmp/MAContent10_GarageBandCoreContent_v3.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsChillwave.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsDeepHouse.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsDubstep.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsElectroHouse.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsGarageBand.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsHipHop.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsJamPack1.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsModernRnB.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsRemixTools.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsRhythmSection.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsSymphony.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsTechHouse.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_PremiumPreLoopsWorld.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_GarageBandCoreContent2.pkg -target /
sleep 5
/usr/sbin/installer -pkg /private/tmp/MAContent10_GarageBandPremiumContent.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_GB_StereoDrumKitsAlternative.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_GB_StereoDrumKitsRock.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_GB_StereoDrumKitsRnB.pkg -target /
/usr/sbin/installer -pkg /private/tmp/MAContent10_GB_StereoDrumKitsSongWriter.pkg -target /
else
echo "You must have more than 15.25GB free to install GarageBand additional content.  Aborting install and cleaning up packages"
exit 1      ## Failure
fi
sleep 5
rm -rf /private/tmp/MAContent10_GarageBandCoreContent_v3.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsChillwave.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsDeepHouse.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsDubstep.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsElectroHouse.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsGarageBand.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsHipHop.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsJamPack1.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsModernRnB.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsRemixTools.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsRhythmSection.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsSymphony.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsTechHouse.pkg
rm -rf /private/tmp/MAContent10_PremiumPreLoopsWorld.pkg
rm -rf /private/tmp/MAContent10_GarageBandCoreContent2.pkg
rm -rf /private/tmp/MAContent10_GarageBandPremiumContent.pkg
rm -rf /private/tmp/MAContent10_GB_StereoDrumKitsAlternative.pkg
rm -rf /private/tmp/MAContent10_GB_StereoDrumKitsRock.pkg
rm -rf /private/tmp/MAContent10_GB_StereoDrumKitsRnB.pkg
rm -rf /private/tmp/MAContent10_GB_StereoDrumKitsSongWriter.pkg

exit 0      ## Success
