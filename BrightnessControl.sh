#!/usr/bin/env sh

direction=$1

    if [ "$direction" == "-" ]; then
        sudo light -U 5
    else
        sudo light -A 5
    fi


# direction=$1
#
# monitor_data=$(hyprctl monitors -j)
# focused_name=$(echo $monitor_data | jq -r '.[] | select(.focused == true) | .name')
#
# if [ "$focused_name" == "eDP-1" ]; then
#     if [ "$direction" == "-" ]; then
#         sudo brillo -u 150000 -U 8
#     else
#         sudo brillo -u 150000 -A 8
#     fi
# else
#     focused_id=$(echo $monitor_data | jq -r '.[] | select(.focused == true) | .id')
#     ddcutil --display=$focused_id setvcp 10 $direction 8
# fi





# #!/bin/bash
#
# brightness=$1
# length=${#brightness}
#
# if [ "${brightness:0:1}" = "+" ]; then
#     brightness_delta=${brightness:1:$((length-1))}
#
#     sudo light -A $brightness_delta & ddcutil setvcp 10 + $brightness_delta &
#
# elif [ "${brightness:0:1}" = "-" ]; then
#     brightness_delta=${brightness:1:$((length-1))}
#
#     sudo light -U $brightness_delta & ddcutil setvcp 10 - $brightness_delta &
#
# else
#     sudo light -S $brightness & ddcutil setvcp 10 $brightness &
# fi
