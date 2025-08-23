#!/bin/bash

# Get all notification IDs
readarray -t notifications < <(notify-send -p)

# Check if notifications are already disabled
if [ -f /tmp/dnd ]; then
    # Re-enable notifications
    rm /tmp/dnd
    for id in "${notifications[@]}"; do
        gdbus call --session \
            --dest=org.freedesktop.Notifications \
            --object-path=/org/freedesktop/Notifications \
            --method=org.freedesktop.Notifications.CloseNotification "$id"
    done
    notify-send "Notifications enabled"
else
    # Disable notifications
    touch /tmp/dnd
    for id in "${notifications[@]}"; do
        gdbus call --session \
            --dest=org.freedesktop.Notifications \
            --object-path=/org/freedesktop/Notifications \
            --method=org.freedesktop.Notifications.CloseNotification "$id"
    done
    read -r -p "Enter duration (minutes, empty for indefinite): " duration
    if [ -n "$duration" ]; then
        (sleep "$((duration * 60))" && rm "/tmp/dnd" && notify-send "DND disabled after $duration minutes") &
    fi
fi