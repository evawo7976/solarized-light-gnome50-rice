#!/bin/bash
# Generate Plymouth boot screen assets and GRUB font
# Requires: ImageMagick 7, grub2-mkfont, liberation-sans-fonts

set -e

PLYMOUTH_DIR="/usr/share/plymouth/themes/solarized-light"
GRUB_DIR="/boot/grub2/themes/solarized-light"

echo "=== Generating Plymouth assets ==="
sudo mkdir -p "$PLYMOUTH_DIR"

# Background (4K retro sunrise)
echo "  Generating 4K background..."
sudo magick -size 3840x2160 xc:'#fdf6e3' \
  \( -size 3840x2160 xc:none \
    -fill '#b5890040' -draw "polygon 1920,1800 1720,0 2120,0" \
    -fill '#cb4b1640' -draw "polygon 1920,1800 1280,0 1720,0" \
    -fill '#dc322f40' -draw "polygon 1920,1800 720,0 1280,0" \
    -fill '#d3368240' -draw "polygon 1920,1800 120,0 720,0" \
    -fill '#6c71c440' -draw "polygon 1920,1800 0,0 120,0 0,600" \
    -fill '#268bd240' -draw "polygon 1920,1800 2120,0 2600,0" \
    -fill '#2aa19840' -draw "polygon 1920,1800 2600,0 3120,0" \
    -fill '#85990040' -draw "polygon 1920,1800 3120,0 3720,0" \
    -fill '#b5890040' -draw "polygon 1920,1800 3720,0 3840,0 3840,600" \
    -blur 0x16 \) \
  -composite \
  \( -size 1200x1200 xc:none \
    -fill '#b58900' -draw "circle 600,600 600,40" \
    -blur 0x30 \) \
  -gravity south -geometry +0+100 -composite \
  \( -size 1040x1040 xc:none \
    -fill '#fdf6e3' -draw "circle 520,520 520,60" \
    -blur 0x10 \) \
  -gravity south -geometry +0+180 -composite \
  "$PLYMOUTH_DIR/background.png"

# Spinner frames (12 color-cycling dots)
echo "  Generating spinner frames..."
COLORS=("#2aa198" "#268bd2" "#6c71c4" "#d33682" "#dc322f" "#cb4b16" "#b58900" "#859900" "#2aa198" "#268bd2" "#6c71c4" "#d33682")
for i in $(seq 0 11); do
  sudo magick -size 32x32 xc:none \
    -fill "${COLORS[$i]}" -draw "circle 16,16 16,2" \
    "$PLYMOUTH_DIR/spinner-$(printf '%02d' $i).png"
done

# Progress bar and track
echo "  Generating progress bar..."
sudo magick -size 400x8 xc:none -fill '#2aa198' -draw "roundrectangle 0,0 400,8 4,4" "$PLYMOUTH_DIR/progress-bar.png"
sudo magick -size 400x8 xc:none -fill '#eee8d5' -draw "roundrectangle 0,0 400,8 4,4" "$PLYMOUTH_DIR/progress-track.png"

# Password entry assets
echo "  Generating password entry assets..."
sudo magick -size 300x40 xc:none -fill '#eee8d5' -stroke '#2aa198' -strokewidth 2 -draw "roundrectangle 1,1 299,39 8,8" "$PLYMOUTH_DIR/entry.png"
sudo magick -size 16x16 xc:none -fill '#2aa198' -draw "circle 8,8 8,1" "$PLYMOUTH_DIR/bullet.png"
sudo magick -size 32x32 xc:none -fill '#586e75' -draw "roundrectangle 4,14 28,30 4,4" -fill none -stroke '#586e75' -strokewidth 3 -draw "arc 8,2 24,20 0,180" "$PLYMOUTH_DIR/lock.png"

echo "=== Generating GRUB assets ==="
sudo mkdir -p "$GRUB_DIR"

# GRUB fonts
echo "  Generating GRUB fonts..."
FONT_PATH=$(fc-list | grep -i "LiberationSans-Regular.ttf" | head -1 | cut -d: -f1)
if [ -n "$FONT_PATH" ]; then
  sudo grub2-mkfont -s 24 -o "$GRUB_DIR/font_24.pf2" "$FONT_PATH"
  sudo grub2-mkfont -s 16 -o "$GRUB_DIR/font_16.pf2" "$FONT_PATH"
else
  echo "  WARNING: Liberation Sans not found, skipping GRUB fonts"
fi

# GRUB selection highlight images
echo "  Generating GRUB selection images..."
sudo magick -size 1x40 xc:'#2aa198' "$GRUB_DIR/select_c.png"
sudo magick -size 4x40 xc:'#2aa198' "$GRUB_DIR/select_w.png"
sudo magick -size 4x40 xc:'#2aa198' "$GRUB_DIR/select_e.png"

echo "=== All assets generated ==="
