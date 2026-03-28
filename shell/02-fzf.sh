#!/bin/bash
# fzf initialization and Solarized Light theme
eval "$(fzf --bash)"

export FZF_DEFAULT_OPTS="
  --color=bg+:#eee8d5,bg:#fdf6e3,spinner:#2aa198,hl:#268bd2
  --color=fg:#657b83,header:#268bd2,info:#b58900,pointer:#2aa198
  --color=marker:#2aa198,fg+:#586e75,prompt:#b58900,hl+:#268bd2
  --color=border:#93a1a1
  --border=rounded
  --padding=1
  --margin=0
  --prompt='  '
  --pointer='▶'
  --marker='✓'
"
