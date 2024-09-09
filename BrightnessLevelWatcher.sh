#!/bin/bash

inotifywait -m /sys/class/backlight/amdgpu_bl1/brightness | while read -r event; do
    if echo "$event" | grep -q "MODIFY"; then
        brightness=$(light -G | cut -d'.' -f1)

        eww update brightness_level="$brightness"
    fi
done
