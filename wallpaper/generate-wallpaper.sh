#!/bin/bash
# Generate Solarized Light stripes wallpaper at 4K (3840x2160)
# Requires: ImageMagick 7 (magick command)

set -e

OUTPUT_DIR="${1:-$HOME/Pictures/Wallpapers}"
mkdir -p "$OUTPUT_DIR"

echo "Generating Solarized Light stripes wallpaper..."
magick -size 3840x2160 xc:'#fdf6e3' \
  -strokewidth 0 \
  -fill '#b58900' -draw "polygon 850,2160 1050,2160 3200,0 3000,0" \
  -fill '#cb4b16' -draw "polygon 1050,2160 1210,2160 3360,0 3200,0" \
  -fill '#dc322f' -draw "polygon 1210,2160 1370,2160 3520,0 3360,0" \
  -fill '#d33682' -draw "polygon 1370,2160 1570,2160 3720,0 3520,0" \
  -fill '#6c71c4' -draw "polygon 1570,2160 1720,2160 3870,0 3720,0" \
  -fill '#268bd2' -draw "polygon 1720,2160 1880,2160 4030,0 3870,0" \
  -fill '#2aa198' -draw "polygon 1880,2160 2040,2160 4190,0 4030,0" \
  -fill '#859900' -draw "polygon 2040,2160 2240,2160 4390,0 4190,0" \
  "$OUTPUT_DIR/solarized-stripes-4k.png"

echo "Wallpaper saved to $OUTPUT_DIR/solarized-stripes-4k.png"
