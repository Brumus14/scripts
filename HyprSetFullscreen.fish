#!/bin/fish

set fullscreen (hyprctl activewindow -j | jq -r ".fullscreen")

if test "$argv" != "$fullscreen"
  hyprctl dispatch fullscreen
end
