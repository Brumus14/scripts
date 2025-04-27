#!/usr/bin/env sh

arg=$1

#!/bin/bash

action=$1
monitor_name=$2
monitor_data=$(hyprctl monitors -j)

if [ "$monitor_name" == "" ]; then
    monitor_name=$(echo $monitor_data | jq -r '.[] | select(.focused == true) | .name')
fi

monitor_serial=$(echo "$monitor_data" | jq -r ".[] | select(.name == \"$monitor_name\") | .serial")

if [ "$monitor_name" == "eDP-1" ]; then
    if [ "$action" == "g" ]; then
        light -G
    elif [ "$action" == "-" ]; then
        sudo light -U 5
    elif [ "$action" == "+" ]; then
        sudo light -A 5
    else
        sudo light -S "$action"
    fi
else
    if [ "$action" == "g" ]; then
        ddcutil -n "$monitor_serial" getvcp 10 | sed -n 's/.*current value = *\([0-9]*\).*/\1/p'
    else
        if [ "$action" == "-" ]; then
            ddcutil -n "$monitor_serial" setvcp 10 - 5
        elif [ "$action" == "+" ]; then
            ddcutil -n "$monitor_serial" setvcp 10 + 5
        else
            ddcutil -n "$monitor_serial" setvcp 10 "$action"
        fi
    fi
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
