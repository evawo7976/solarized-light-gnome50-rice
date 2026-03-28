#!/bin/bash
# Solarized Light dircolors
if [ ! -f ~/.dir_colors ]; then
  curl -fsSL https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-light -o ~/.dir_colors 2>/dev/null
fi
if [ -f ~/.dir_colors ]; then
  eval "$(dircolors -b ~/.dir_colors)"
fi
