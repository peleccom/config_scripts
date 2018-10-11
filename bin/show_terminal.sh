#!/bin/sh

# Make terminal window singletone

xdotool windowactivate `xdotool search --classname "Gnome-terminal" |tail -1` || gnome-terminal
