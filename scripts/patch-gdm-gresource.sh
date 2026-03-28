#!/bin/bash
# Patch GDM login screen with Solarized Light theme
# Modifies gnome-shell-theme.gresource to use Solarized Light background + colors
# Requires: glib-compile-resources, ImageMagick

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
GRESOURCE="/usr/share/gnome-shell/gnome-shell-theme.gresource"
WORK_DIR="/tmp/gdm-solarized-patch"

echo "=== Patching GDM Login Screen ==="

# Back up original
if [ ! -f "${GRESOURCE}.backup" ]; then
  echo "  Backing up original gresource..."
  sudo cp "$GRESOURCE" "${GRESOURCE}.backup"
else
  echo "  Backup already exists"
fi

# Extract all theme files
echo "  Extracting theme files..."
rm -rf "$WORK_DIR" && mkdir -p "$WORK_DIR"
cd "$WORK_DIR"
for r in $(gresource list "$GRESOURCE"); do
  mkdir -p "$(dirname ".${r}")"
  gresource extract "$GRESOURCE" "$r" > ".${r}"
done

# Copy wallpaper into theme
echo "  Adding Solarized wallpaper..."
cp /usr/share/backgrounds/solarized-stripes-4k.png ./org/gnome/shell/theme/solarized-bg.png

# Patch gnome-shell-light.css
echo "  Patching CSS..."
python3 << 'PYEOF'
css_path = './org/gnome/shell/theme/gnome-shell-light.css'
with open(css_path, 'r') as f:
    css = f.read()

css = css.replace(
    '#lockDialogGroup {\n  background-color: #222226; }',
    '#lockDialogGroup {\n  background: #fdf6e3 url(resource:///org/gnome/shell/theme/solarized-bg.png) no-repeat center center;\n  background-size: cover; }'
)
css = css.replace(
    '.screen-shield-background {\n  background: black;',
    '.screen-shield-background {\n  background: #fdf6e3;'
)

# Append Solarized Light login dialog overrides
css += """

/* Solarized Light Login Screen Overrides */
#lockDialogGroup {
  background: #fdf6e3 url(resource:///org/gnome/shell/theme/solarized-bg.png) no-repeat center center !important;
  background-size: cover !important;
}
.screen-shield-background { background: #fdf6e3 !important; }
.login-dialog, .unlock-dialog { color: #586e75 !important; }
.login-dialog .user-widget .user-widget-label { color: #073642 !important; font-size: 1.2em !important; }
.login-dialog .user-widget.horizontal .user-widget-label { color: #073642 !important; }
.login-dialog .login-dialog-prompt-entry, .unlock-dialog .login-dialog-prompt-entry {
  background-color: rgba(253, 246, 227, 0.9) !important; color: #586e75 !important;
  border: 2px solid #2aa198 !important; border-radius: 8px !important; }
.login-dialog .login-dialog-prompt-entry:focus, .unlock-dialog .login-dialog-prompt-entry:focus {
  border-color: #268bd2 !important; box-shadow: 0 0 0 3px rgba(42, 161, 152, 0.3) !important; }
.login-dialog .login-dialog-prompt-label { color: #657b83 !important; }
.login-dialog .caps-lock-warning-label, .login-dialog .login-dialog-message-warning { color: #cb4b16 !important; }
.login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item { color: #586e75 !important; border-radius: 12px !important; }
.login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:hover { background-color: rgba(238, 232, 213, 0.8) !important; }
.login-dialog-user-list-view .login-dialog-user-list .login-dialog-user-list-item:selected { background-color: rgba(42, 161, 152, 0.2) !important; }
.login-dialog-button.cancel-button, .login-dialog-button.switch-user-button,
.login-dialog-button.login-dialog-session-list-button, .login-dialog-button.a11y-button {
  color: #586e75 !important; background-color: rgba(238, 232, 213, 0.8) !important; border-radius: 50% !important; }
.login-dialog-button.cancel-button:hover, .login-dialog-button.switch-user-button:hover,
.login-dialog-button.login-dialog-session-list-button:hover, .login-dialog-button.a11y-button:hover {
  background-color: rgba(238, 232, 213, 1) !important; color: #2aa198 !important; }
.login-dialog-not-listed-button { color: #268bd2 !important; background-color: transparent !important; border-radius: 8px !important; }
.login-dialog-not-listed-button:hover { color: #2aa198 !important; background-color: rgba(238, 232, 213, 0.8) !important; }
.login-dialog-not-listed-button:active { color: #fdf6e3 !important; background-color: #2aa198 !important; }
.unlock-dialog-clock-time { color: #073642 !important; font-weight: 700 !important; }
.unlock-dialog-clock-date, .unlock-dialog-clock-hint { color: #586e75 !important; }
"""

with open(css_path, 'w') as f:
    f.write(css)
print("  CSS patched successfully")
PYEOF

# Create gresource XML manifest
echo "  Creating manifest..."
cat > gnome-shell-theme.gresource.xml << 'XMLEOF'
<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource prefix="/org/gnome/shell/theme">
    <file>calendar-today-light.svg</file>
    <file>calendar-today.svg</file>
    <file>gnome-shell-dark.css</file>
    <file>gnome-shell-high-contrast.css</file>
    <file>gnome-shell-light.css</file>
    <file>gnome-shell-start.svg</file>
    <file>pad-osd.css</file>
    <file>solarized-bg.png</file>
    <file>workspace-placeholder.svg</file>
  </gresource>
</gresources>
XMLEOF

# Compile and install
echo "  Compiling gresource..."
cd ./org/gnome/shell/theme
glib-compile-resources --sourcedir=. "$WORK_DIR/gnome-shell-theme.gresource.xml" --target="$WORK_DIR/gnome-shell-theme.gresource"

echo "  Installing..."
sudo cp "$WORK_DIR/gnome-shell-theme.gresource" "$GRESOURCE"

# Set up GDM dconf
echo "  Configuring GDM dconf..."
sudo mkdir -p /etc/dconf/db/gdm.d/
sudo cp "$REPO_DIR/boot/gdm/01-solarized-light" /etc/dconf/db/gdm.d/

sudo tee /etc/dconf/profile/gdm > /dev/null << 'EOF'
user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults
EOF

sudo dconf update

echo "=== GDM patched successfully ==="
echo "Log out to see the new login screen."
echo "Rollback: sudo cp ${GRESOURCE}.backup $GRESOURCE"
