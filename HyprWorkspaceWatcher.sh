#!/bin/bash

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
    stdbuf -o0 awk -F '>>|,' '
        /^workspace>>/ {print $2}
    ' | while read -r workspace; do
            workspace_number=$((((workspace - 1) % 9) + 1))
            display_number=$(((workspace - 1) / 9))
            eww update "workspace$display_number"=${workspace_number}
        done
