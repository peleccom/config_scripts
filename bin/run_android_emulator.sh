#!/bin/bash
(
    cd "$ANDROID_HOME/emulator" || exit 1
    ./emulator "$(./emulator -list-avds | head -n 1)"
)