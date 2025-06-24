#!/bin/bash

action=$1
monitor_name=$2
monitor_data=$(hyprctl monitors -j)

if [ "$monitor_name" == "" ]; then
    monitor_name=$(echo $monitor_data | jq -r '.[] | select(.focused == true) | .name')
fi

monitor_id=$(echo "$monitor_data" | jq -r ".[] | select(.name == \"$monitor_name\") | .id")
ddcutil_id=$((monitor_id + 1))

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
        ddcutil --display="$ddcutil_id" getvcp 10 | sed -n 's/.*current value = *\([0-9]*\).*/\1/p'
    else
        if [ "$action" == "-" ]; then
            ddcutil --display="$ddcutil_id" setvcp 10 - 5
            brightness_level=$(eww get brightness_level$monitor_id)
            new_brightness_level=$(($brightness_level - 5 < 0 ? 0 : $brightness_level - 5))
            eww update brightness_level$monitor_id=$new_brightness_level
        elif [ "$action" == "+" ]; then
            ddcutil --display="$ddcutil_id" setvcp 10 + 5
            brightness_level=$(eww get brightness_level$monitor_id)
            new_brightness_level=$(($brightness_level + 5 > 100 ? 100 : $brightness_level + 5))
            eww update brightness_level$monitor_id=$new_brightness_level
        else
            brightness_level=$(($action > 100 ? 100 : $action))
            brightness_level=$(($brightness_level < 0 ? 0 : $brightness_level))
            eww update brightness_level$monitor_id=$brightness_level
            ddcutil --display="$ddcutil_id" setvcp 10 "$brightness_level"
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
