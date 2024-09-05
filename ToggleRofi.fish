#!/bin/fish

if pgrep -x rofi >/dev/null
    pkill -x rofi
else
    rofi -show run
end
