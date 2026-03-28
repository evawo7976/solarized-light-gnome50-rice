# Solarized Light Rice for GNOME 50

A comprehensive Solarized Light theme for Fedora Rawhide 45+ with GNOME 50. Themes every visible surface from boot to desktop.

## What's Themed

| Surface | Details |
|---------|---------|
| **GNOME Desktop** | Light mode, teal accent, Papirus-Light icons, Bibata cursor, Blur my Shell, Forge tiling |
| **GNOME Shell** | Custom shell theme (top bar, quick settings, calendar, notifications) |
| **Terminal (Ptyxis)** | Custom Solarized Light palette with improved readability, JetBrains Mono Nerd Font |
| **Shell Prompt** | Starship with light pastel powerline segments |
| **CLI Tools** | bat, eza, delta, fzf, btop, cava, lazygit, yazi, glow -- all Solarized Light |
| **tmux** | Solarized Light status bar with powerline segments |
| **fastfetch** | Solarized-colored system info with Nerd Font icons |
| **Neovim** | Solarized Light colorscheme, treesitter, telescope, lualine |
| **VS Code** | Solarized Light + material icons + full color customizations |
| **Zen Browser** | userChrome.css with Solarized Light toolbar/sidebar/tabs |
| **Obsidian** | CSS snippet with Solarized Light colors and rotating heading colors |
| **Slack** | Custom CSS + sidebar theme string |
| **GTK 3/4** | CSS overrides for headerbars, sidebars, selections, links, tooltips |
| **Wallpaper** | Generated 4K Solarized stripes (ImageMagick) |
| **Git** | Delta with Solarized Light, colored status/branch/diff, pretty log alias |
| **Man pages** | Solarized syntax highlighting via bat |
| **GRUB** | Solarized Light boot menu (cream background, teal selection) |
| **Plymouth** | Custom Solarized sunrise boot animation with color-cycling spinner |
| **GDM Login** | Patched gresource with Solarized stripes wallpaper + light UI (optional) |

## Solarized Light Palette

```
Base3:   #fdf6e3  (background)     Yellow:  #b58900
Base2:   #eee8d5  (highlights)     Orange:  #cb4b16
Base1:   #93a1a1  (comments)       Red:     #dc322f
Base00:  #657b83  (body text)      Magenta: #d33682
Base01:  #586e75  (emphasis)       Violet:  #6c71c4
Base02:  #073642  (dark)           Blue:    #268bd2
Base03:  #002b36  (darkest)        Cyan:    #2aa198
                                   Green:   #859900
```

## Requirements

- Fedora Rawhide 45+ (or Fedora 42+ with GNOME 50)
- GNOME 50 with Ptyxis terminal
- sudo access (for Plymouth, GRUB, GDM, and package installation)
- Internet connection (for downloading fonts, cursor, and packages)

## Quick Install

```bash
git clone https://github.com/NicksLameCode/solarized-light-gnome50-rice.git
cd solarized-light-gnome50-rice
chmod +x install.sh
./install.sh
```

## Post-Install

1. **Log out and back in** (or reboot) for GNOME Shell theme + extensions
2. **Open a new terminal** to see starship prompt + fastfetch greeting
3. **Run `nvim` once** to let lazy.nvim install plugins
4. **Restart Zen Browser** for userChrome.css
5. **Obsidian**: Settings > Appearance > Light mode + enable "solarized-light" CSS snippet
6. **Slack sidebar**: Paste in Preferences > Themes > Custom:
   ```
   #eee8d5,#ddd6c1,#2aa198,#fdf6e3,#ddd6c1,#586e75,#859900,#268bd2,#eee8d5,#657b83
   ```

## Uninstall

```bash
./uninstall.sh
```

Restores GNOME defaults, GDM, Plymouth, and GRUB. Config files in `~/.config/` are left in place for manual cleanup.

## File Structure

```
shell/          # Bash shell scripts (starship, fzf, dircolors, bat/eza, zoxide, man pages)
config/         # CLI tool configs (starship, tmux, fastfetch, btop, nvim, lazygit, yazi, cava, glow, vscode)
gtk/            # GTK 3/4 CSS overrides and settings
gnome-shell/    # Custom GNOME Shell theme
terminal/       # Ptyxis terminal palette
browser/        # Zen Browser userChrome.css
apps/           # Obsidian + Slack themes
boot/           # Plymouth, GRUB, and GDM configs
wallpaper/      # Wallpaper generation script
git/            # Git delta + color config
scripts/        # Asset generation and GDM patching scripts
```

## Credits

- [Ethan Schoonover](https://ethanschoonover.com/solarized/) - Solarized color palette
- [Starship](https://starship.rs/) - Cross-shell prompt
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/) - Monospace font
- [Nerd Fonts](https://www.nerdfonts.com/) - Patched fonts with icons
- [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) - Icon theme
- [Bibata](https://github.com/ful1e5/Bibata_Cursor) - Cursor theme
- [dircolors-solarized](https://github.com/seebi/dircolors-solarized) - LS_COLORS

## License

MIT
