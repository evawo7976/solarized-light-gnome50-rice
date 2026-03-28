#!/bin/bash
# Solarized Light man pages via bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Colored less output with Solarized Light
export LESS_TERMCAP_mb=$'\e[1;38;2;220;50;47m'                     # begin blink - red
export LESS_TERMCAP_md=$'\e[1;38;2;38;139;210m'                     # begin bold - blue
export LESS_TERMCAP_me=$'\e[0m'                                      # end mode
export LESS_TERMCAP_se=$'\e[0m'                                      # end standout
export LESS_TERMCAP_so=$'\e[38;2;253;246;227;48;2;42;161;152m'      # standout - cream on teal
export LESS_TERMCAP_ue=$'\e[0m'                                      # end underline
export LESS_TERMCAP_us=$'\e[4;38;2;133;153;0m'                      # begin underline - green
