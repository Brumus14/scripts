#!/bin/bash

# socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" |
#     while read -r line; do
#         if [[ $line == *"monitoraddedv2"* ]]; then
#             line=${line#monitoraddedv2>>}
#             id=$(echo  $line | cut -d , -f 1)
#             name=$(echo $line | cut -d, -f 2)
#
#             esh ~/.config/eww/esh_eww.yuck > ~/.config/eww/eww.yuck
#             eww reload
#
#             esh ~/.config/hypr/esh_hyprland.conf > ~/.config/hypr/hyprland.conf
#             hyprland reload
#
#             eww open "bar$id"
#         elif [[ $line == *"monitorremovedv2"* ]]; then
#             line=${line#monitorremovedv2>>}
#             id=$(echo  $line | cut -d , -f 1)
#             name=$(echo $line | cut -d, -f 2)
#
#             eww close "bar$id"
#
#             esh ~/.config/eww/esh_eww.yuck > ~/.config/eww/eww.yuck
#             eww reload
#
#             esh ~/.config/hypr/esh_hyprland.conf > ~/.config/hypr/hyprland.conf
#             hyprland reload
#         fi
#     done


socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" |
    while read -r line; do
        if [[ $line == *"monitoraddedv2"* ]]; then
            line=${line#monitoraddedv2>>}
            id=$(echo  $line | cut -d , -f 1)

            esh ~/.config/eww/esh_eww.yuck > ~/.config/eww/eww.yuck
            eww reload
            eww open "bar$id"
            
            # hyprctl dispatch exec "[floating; monitor 0; stayfocused; pin; center]" nwg-displays
        fi
    done
