#!/bin/bash

# Input devices
xinput set-prop "Glorious Model O" "libinput Accel Speed" -0.6
setxkbmap gb

# Displays
xrandr --output DP-0 --mode 1920x1080 --rate 240 --primary --output DP-2 --mode 1920x1080 --rate 60 --left-of DP-0

# Wallpaper
feh --no-xinerama --bg-fil Documents/Wallpapers/SombreroGalaxy.jpg

# Polybar
./Documents/Scripts/LaunchPolybar.sh

# Hide cursor when idle
unclutter -idle 2 &
