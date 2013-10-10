#!/bin/bash

z_version=$(defaults read /Library/Widgets/Zidget.wdgt/Info CFBundleVersion)

echo "<result>${z_version}</result>"
