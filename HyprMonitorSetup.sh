#!/bin/bash

esh ~/.config/eww/esh_eww.yuck > ~/.config/eww/eww.yuck
eww reload

esh ~/.config/hypr/esh_hyprland.conf > ~/.config/hypr/hyprland.conf
hyprland reload
