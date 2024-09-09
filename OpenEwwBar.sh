#!/bin/bash

eww open-many --toggle bar0 bar1

eww update volume_level=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n 1)
eww update brightness_level=$(light -G | cut -d'.' -f1)
