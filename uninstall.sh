#!/bin/bash
# Solarized Light Rice - Uninstaller
# Restores GNOME defaults without removing installed packages

set -e

echo "Solarized Light Rice - Uninstaller"
echo "==================================="
echo "This will restore GNOME defaults. Installed packages will remain."
read -rp "Continue? [y/N] " choice
[[ ! "$choice" =~ ^[Yy]$ ]] && exit 0

# Restore GNOME defaults
gsettings reset org.gnome.desktop.interface color-scheme
gsettings reset org.gnome.desktop.interface accent-color
gsettings reset org.gnome.desktop.interface icon-theme
gsettings reset org.gnome.desktop.interface cursor-theme
gsettings reset org.gnome.desktop.interface monospace-font-name
gsettings reset org.gnome.desktop.background picture-uri
gsettings reset org.gnome.desktop.background picture-uri-dark
gsettings reset org.gnome.shell.extensions.user-theme name
gsettings reset org.gnome.Ptyxis interface-style
gsettings reset org.gnome.Ptyxis use-system-font
gsettings reset org.gnome.Ptyxis font-name

# Restore GDM if patched
if [ -f /usr/share/gnome-shell/gnome-shell-theme.gresource.backup ]; then
  echo "Restoring GDM theme..."
  sudo cp /usr/share/gnome-shell/gnome-shell-theme.gresource.backup \
          /usr/share/gnome-shell/gnome-shell-theme.gresource
  sudo rm -f /etc/dconf/profile/gdm /etc/dconf/db/gdm.d/01-solarized-light
  sudo dconf update
fi

# Restore Plymouth
sudo plymouth-set-default-theme spinner 2>/dev/null || true
sudo dracut -f 2>/dev/null || true

# Restore GRUB
sudo sed -i '/GRUB_THEME/d' /etc/default/grub 2>/dev/null || true
sudo sed -i 's|GRUB_TERMINAL_OUTPUT="gfxterm"|GRUB_TERMINAL_OUTPUT="console"|' /etc/default/grub 2>/dev/null || true
sudo grub2-mkconfig -o /boot/grub2/grub.cfg 2>/dev/null || true

echo ""
echo "Defaults restored. Log out/reboot for full effect."
echo "Config files in ~/.config/, ~/.bashrc.d/, ~/.tmux.conf were NOT removed."
echo "Remove them manually if desired."
