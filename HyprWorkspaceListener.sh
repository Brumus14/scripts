#!/bin/bash

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
    stdbuf -o0 awk -F '>>|,' '
        /^workspace>>/ {print $2}
    ' | while read -r workspace; do
            if [ ${workspace} -le 5 ]; then
                eww update "workspace0"=${workspace}
            else
                eww update "workspace1"=$((workspace - 5))
            fi
        done
