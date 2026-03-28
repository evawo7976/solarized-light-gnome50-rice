#!/bin/bash
# Solarized Light shell greeting
if [[ $- == *i* ]] && [[ -z "$TMUX_PANE" || "$TMUX_PANE" == "%0" ]]; then
  # Solarized cyan color
  CYAN='\033[38;2;42;161;152m'
  BLUE='\033[38;2;38;139;210m'
  RESET='\033[0m'

  # Figlet hostname banner in cyan
  echo -e "${CYAN}"
  figlet -f small "$(hostname -s)" 2>/dev/null
  echo -e "${RESET}"

  # Fastfetch system info
  fastfetch

  # Random fortune with cowsay in blue
  if command -v cowsay &>/dev/null && command -v fortune &>/dev/null; then
    echo -e "${BLUE}"
    fortune -s 2>/dev/null | cowsay -f small 2>/dev/null
    echo -e "${RESET}"
  fi
fi
