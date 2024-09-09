#!/bin/bash

pactl subscribe | while read -r event; do
    if echo "$event" | grep -q "Event 'change' on sink"; then
        echo "change"
        volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n 1)
        
        is_muted=$(pactl get-sink-mute @DEFAULT_SINK@)
        echo $is_muted

        if [ "$is_muted" = "Mute: yes" ]; then
            eww update volume_level="0"
        else
            eww update volume_level="$volume"
        fi
    fi
done
