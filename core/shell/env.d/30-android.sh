# Android SDK configuration
if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_HOME=$HOME/Android/Sdk
    export ANDROID_SDK_ROOT=$ANDROID_HOME
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/platform-tools
fi

# Dart configuration
export PATH="$PATH":"$HOME/.pub-cache/bin"
