#!/bin/bash

max=150
min=0

current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n 1)

volume=$1
length=${#volume}

if [ "${volume:0:1}" = "+" ]; then
    new_volume=$((current_volume+${volume:1:$((length-2))}))

    if (( new_volume > max )); then
        echo $max
        pactl set-sink-volume @DEFAULT_SINK@ $max%
    else
        echo +${volume:1:$((length-2))}
        pactl set-sink-volume @DEFAULT_SINK@ +${volume:1:$((length-2))}%
    fi

elif [ "${volume:0:1}" = "-" ]; then
    new_volume=$((current_volume-${volume:1:$((length-2))}))

    if (( new_volume < min )); then
        echo $min
        pactl set-sink-volume @DEFAULT_SINK@ $min%
    else
        echo -${volume:1:$((length-2))}
        pactl set-sink-volume @DEFAULT_SINK@ -${volume:1:$((length-2))}%
    fi

else
    new_volume=${volume:0:$((length-1))}

    if (( $new_volume >= min )); then
        if (( $new_volume <= max)); then
            echo $new_volume
            pactl set-sink-volume @DEFAULT_SINK@ $new_volume%
        else
            pactl set-sink-volume @DEFAULT_SINK@ $max%
        fi
    else
        pactl set-sink-volume @DEFAULT_SINK@ $min%
    fi
fi

echo $(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n 1)
