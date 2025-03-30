#!/bin/bash

# inotifywait -m /sys/class/backlight/amdgpu_bl1/brightness | while read -r event; do
#     if echo "$event" | grep -q "MODIFY"; then
#         brightness=$(light -G | cut -d'.' -f1)
#
#         eww update brightness_level="$brightness"
#     fi
# done

while true
do
    # maybe just check for focused monitor
    for id in $(hyprctl monitors -j | jq -r '.[] | .id'); do
        brightness=$(ddcutil getvcp 10 | sed -n 's/.*current value = *\([0-9]*\).*/\1/p')
        eww update brightness_level$id=$brightness
    done
done
