#!/bin/bash

# I combined the XProtect scripts in rtrouton's github repo into one so that
# I can use WatchPaths to fix it with one launchd job

flash() {
    current_flash_build=$(/usr/libexec/PlistBuddy -c "print :CFBundleShortVersionString" "/Library/Internet Plug-Ins/Flash Player.plugin/Contents/Info.plist")
    xprotect_flash_build=$(/usr/libexec/PlistBuddy -c "print :PlugInBlacklist:10:com.macromedia.Flash\ Player.plugin:MinimumPlugInBundleVersion" /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist)

    if [[ "${current_flash_build}" != ${xprotect_flash_build} ]]; then
        /usr/bin/logger "Current Flash build ${current_flash_build} does not match the minimum build required by XProtect ${xprotect_flash_build}. Setting current version as the minimum build."
        /usr/libexec/PlistBuddy -c "Set :PlugInBlacklist:10:com.macromedia.Flash\ Player.plugin:MinimumPlugInBundleVersion ${current_flash_build}" /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist
        /usr/bin/plutil -convert xml1 /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist
        /bin/chmod a+r /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist
    else
        /usr/bin/logger "Current Flash build is ${current_flash_build} and XProtect minimum build is ${xprotect_flash_build}, nothing to do here."
    fi
}

java6() {
    current_java_6_build=$(/usr/libexec/PlistBuddy -c "print :JavaVM:JVMVersion" "/Library/Java/Home/bundle/Info.plist")
    xprotect_java_6_build=$(/usr/libexec/PlistBuddy -c "print :JavaWebComponentVersionMinimum" /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist)

    if [[ "${current_java_6_build}" != ${xprotect_java_6_build} ]]; then
        /usr/bin/logger "Current Java 6 build ${current_java_6_build} does not match the minimum build required by XProtect ${xprotect_java_6_build}. Setting current version as the minimum build."
        /usr/bin/defaults write /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta JavaWebComponentVersionMinimum -string "$current_java_6_build"
        /usr/bin/plutil -convert xml1 /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist
        /bin/chmod a+r /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist
    else
        /usr/bin/logger "Current JVM build is ${current_java_6_build} and XProtect minimum build is ${xprotect_java_6_build}, nothing to do here."
    fi
}

java7() {
    current_java_7_build=$(/usr/libexec/PlistBuddy -c "print :CFBundleVersion" "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Info.plist")
    xprotect_java_7_build=$(/usr/libexec/PlistBuddy -c "print :PlugInBlacklist:10:com.oracle.java.JavaAppletPlugin:MinimumPlugInBundleVersion" /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist)

    if [[ "${current_java_7_build}" != ${xprotect_java_7_build} ]]; then
        /usr/bin/logger "Current Java 7 build ${current_java_7_build} does not match the minimum build required by XProtect ${xprotect_java_7_build}. Setting current version as the minimum build."
        /usr/libexec/PlistBuddy -c "Set :PlugInBlacklist:10:com.oracle.java.JavaAppletPlugin:MinimumPlugInBundleVersion $current_java_7_build" /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist
        /usr/bin/plutil -convert xml1 /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist
        /bin/chmod a+r /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist
    else
        /usr/bin/logger "Current Oracle Java version is ${current_java_7_build} and XProtect minimum version is ${xprotect_java_7_build}, nothing to do here."
    fi
}

main() {
    [[ -e  "/Library/Internet Plug-Ins/Flash Player.plugin/Contents/Info.plist" ]] && flash
    [[ -e /Library/Java/Home/bundle/Info.plist ]] && java6

    if [[ -e "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Info.plist" ]]; then
        osvers=$(/usr/bin/sw_vers -productVersion | awk -F. '{print $2}')
        javaVendor=$(/usr/bin/defaults read "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Info" CFBundleIdentifier)

        if [[ "${osvers}" -ge 7 ]] && [[ "$javaVendor" = com.oracle.java.JavaAppletPlugin ]]; then
            java7
        fi
    fi
}

main
