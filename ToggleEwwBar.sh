#!/bin/bash

# eww update volume_level=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n 1)
# eww update brightness_level=$(light -G | cut -d'.' -f1)

bars=$(eww list-windows | tr "\n" " ")
eww open-many --toggle $bars
