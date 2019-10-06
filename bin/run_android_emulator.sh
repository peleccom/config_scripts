#!/bin/sh
cd $ANDROID_HOME/tools
emulator @$(emulator -list-avds|head -n 1)
cd -
