#!/bin/bash

fullscreen=$(hyprctl activewindow -j | jq -r ".fullscreen")

if [[ "$1" == "true" ]]; then
  if [[ "$fullscreen" == "0" ]]; then
    hyprctl dispatch fullscreen
  fi
fi

if [[ "$1" == "false" ]]; then
  if [[ "$fullscreen" != "0" ]]; then
    hyprctl dispatch fullscreen
  fi
fi
