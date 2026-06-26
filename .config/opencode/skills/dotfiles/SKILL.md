---
name: dotfiles
description: Dotfiles de jpenedou — bare git repo con Niri + DMS (DankMaterialShell) + perfilado multi-máquina. Fuente de verdad para el entorno de escritorio del usuario.
---

# Dotfiles — jpenedou

## Repo

`github.com/jpenedou/dotfiles` — bare git repo en `~/.dotfiles/`.

```zsh
dotfiles() { /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"; }
alias lgd='lazygit --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
```

Comandos útiles:

```zsh
dotfiles status          # estado de los dotfiles
dotfiles add <path>      # añadir archivo al track
dotfiles commit -m "msg"
dotfiles push
dotfiles pull
dotfiles submodule update --init --recursive   # post-clone
dotfiles config --local status.showUntrackedFiles no  # post-clone
```

### Instalación en máquina nueva

```zsh
git clone --bare https://github.com/jpenedou/dotfiles.git ~/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
dotfiles submodule update --init --recursive
```

> ⚠️ `dotfiles checkout` puede fallar por archivos locales existentes. Moverlos o usar `--force`.

---

## WM: Niri

Niri es un compositor Wayland scrollable-tiling. Reemplazó a Hyprland.

### Arquitectura de config

`~/.config/niri/` tiene un sistema modular con generación por perfiles:

```
~/.config/niri/
├── config.kdl              ← GENERADO (no editar directamente)
├── generate_config.sh      ← script que genera config.kdl
├── kdl_merge.py            ← fusiona nodos singleton KDL
├── binds.kdl               ← keybindings base
├── general.kdl             ← startup, environment, prefer-no-csd, etc
├── layout.kdl              ← gaps, focus-ring, border, shadow, struts
├── cursor.kdl              ← xcursor-theme, size
├── animations.kdl          ← animaciones (off por ahora)
├── gestures.kdl            ← hot-corners (bottom-right)
├── recent-windows.kdl      ← Alt+Tab switcher settings
├── window-rule.kdl         ← window rules (maximize, float, blur, corners)
├── input.laptop.kdl        ← input profile: laptop
├── input.minikom.kdl       ← input profile: minikom
├── output.laptop.kdl       ← output profile: laptop
├── output.minikom.kdl      ← output profile: minikom
└── dms/                    ← overrides generados por DMS
    ├── binds.kdl           ← binds de DMS (spotlight, clipboard, audio, etc)
    ├── colors.kdl          ← colores TokyoNight
    ├── layout.kdl          ← layout generado por DMS (gaps, corners)
    ├── alttab.kdl          ← alt-tab corner-radius
    ├── cursor.kdl          ← (vacio)
    ├── outputs.kdl         ← (vacio)
    ├── windowrules.kdl     ← (vacio)
    └── wpblur.kdl          ← layer-rule para blurred wallpaper
```

### Sistema de perfiles

`generate_config.sh <perfil> [subdirs...]` genera `config.kdl`:

- **Perfiles disponibles**: `laptop`, `minikom`
- **Archivos de perfil**: usan naming pattern `nombre.<perfil>.kdl` (ej: `input.laptop.kdl`, `output.minikom.kdl`)
- **Subdirectorios**: `dms` es el principal. Se pasa como arg extra: `./generate_config.sh minikom dms`
- **Fusión**: `kdl_merge.py` fusiona nodos singleton (binds, layout, cursor, input, etc.) cuando hay colisión. `dms/` tiene prioridad sobre base.

```zsh
# Regenerar config activa (minikom + dms)
~/.config/niri/generate_config.sh minikom dms

# laptop
~/.config/niri/generate_config.sh laptop dms
```

### Colores

Tema TokyoNight. Definidos en `dms/colors.kdl`:

| Elemento | Color |
|---|---|
| Focus ring / border active | `#9dcbfb` |
| Focus ring / border inactive | `#8c9199` |
| Focus ring / border urgent | `#ffb4ab` |
| Shadow | `#00000070` |

### Keybindings principales

| Atajo | Acción |
|---|---|
| `Mod+Return` / `Mod5+Return` | Abrir kitty |
| `Mod+W` / `Mod5+W` | Firefox |
| `Mod+T` / `Mod5+T` | TradingView |
| `Mod+D` / `Mod+Space` | DMS launcher (spotlight) |
| `Mod+V` | DMS clipboard |
| `Mod+M` / `Ctrl+Alt+Del` | DMS task manager |
| `Mod+Comma` | DMS settings |
| `Mod+N` | DMS notification center |
| `Mod+Y` | DMS wallpaper browser |
| `Mod+Shift+N` | DMS notepad |
| `Mod+Alt+L` | DMS lock screen (swaylock) |
| `Mod+Q` / `Alt+Space` | Cerrar ventana |
| `Mod+O` / `Mod5+O` | Toggle overview |
| `Mod+F` / `Mod5+F` / `Mod5+Space` | Maximizar columna |
| `Mod+Shift+F` | Fullscreen |
| `Mod+H/J/K/L` | Navegación vi |
| `Mod+1-9` | Workspaces |
| `Mod+Tab` | Previous workspace |
| `Print` | Screenshot region (grim + swappy) |
| `Ctrl+Print` | Screenshot screen |
| `Alt+Print` | Screenshot window |
| `Mod+Escape` / `Mod5+Escape` | wlogout |
| `Mod+Shift+E` | Quit niri |
| `XF86AudioRaiseVolume` | DMS audio +3 |
| `XF86AudioLowerVolume` | DMS audio -3 |
| `XF86AudioMute` | DMS audio mute |
| `XF86MonBrightnessUp` | DMS brightness +5 |
| `XF86MonBrightnessDown` | DMS brightness -5 |

Mod = Super (Windows key). Mod5 = AltGr.

---

## DMS (DankMaterialShell)

Suite de escritorio que reemplaza rofi y waybar. Binario en `/usr/bin/dms`.

`dms run` se ejecuta al inicio (en `general.kdl`: `spawn-sh-at-startup "dms run"`).

### IPC

```zsh
dms ipc call <module> <action> [args...]
```

### Módulos activos

| Módulo | Acciones | Función |
|---|---|---|
| `spotlight` | `toggle` | Application launcher |
| `clipboard` | `toggle` | Clipboard manager |
| `processlist` | `toggle` | Task manager |
| `settings` | `toggle` | Configuración del sistema |
| `notifications` | `toggle` | Notification center |
| `dankdash` | `wallpaper` | Wallpaper browser/manager |
| `notepad` | `toggle` | Notas rápidas |
| `lock` | `lock` | Lock screen (via swaylock) |
| `audio` | `increment N`, `decrement N`, `mute`, `micmute` | Control de volumen |
| `brightness` | `increment N`, `decrement N` | Brillo de pantalla |

### DMS genera archivos en `dms/`

Los archivos con `// ! AUTO-GENERATED BY DMS !` no deben editarse manualmente:
- `dms/layout.kdl`
- `dms/alttab.kdl`
- `dms/wpblur.kdl`

---

## Perfiles de máquina

### minikom (PC de escritorio, actual)

- Outputs: HDMI-A-1 (principal, focus-at-startup), HDMI-A-2 (off)
- XKB options: `caps:escape_shifted_capslock`
- Teclas extra: Mod5 (AltGr) para navegación, workspaces, column-width

### laptop

- Output: eDP-1 1920x1080@120, scale 2, position x=1280 y=0
- XKB options: `caps:escape_shifted_capslock,altwin:prtsc_rwin`
- Igual navegación vi, layout, etc.

---

## Estado de tools trackeadas

### Activas
| Tool | Config | Uso |
|---|---|---|
| **Niri** | `~/.config/niri/` | Compositor Wayland |
| **DMS** | `/usr/bin/dms` | Escritorio (menus, bar, audio, etc) |
| **kitty** | `~/.config/kitty/kitty.conf` | Terminal GPU |
| **zsh + oh-my-zsh** | `~/.zshrc`, `~/.config/oh-my-zsh/` | Shell |
| **nvim + LazyVim** | `~/.config/nvim/` | Editor |
| **yazi** | `~/.config/yazi/` | File manager |
| **lazygit** | `~/.config/lazygit/config.yml` | Git TUI |
| **atuin** | `~/.config/atuin/config.toml` | Shell history |
| **lf** | `~/.config/lf/lfrc` | File manager (terminal) |
| **wlogout** | `~/.config/wlogout/` | Logout/power menu |
| **swaylock** | `~/.config/swaylock/config` | Lock screen |
| **swaync** | `~/.config/swaync/config.json` | Notification center |
| **mpv** | `~/.config/mpv/` | Video player |
| **starship** | (no config file, default) | Prompt |
| **zoxide** | — | Dir jumper |
| **fzf** | `~/.zshrc` (opts) | Fuzzy finder |
| **swappy** | `~/.config/swappy/config` | Screenshot editor |
| **niriswitcher** | `~/.config/niriswitcher/config.toml` | Alt+Tab switcher UI |

### Obsoletas (config preservada, no se usan activamente)
| Tool | Config | Reemplazada por |
|---|---|---|
| **Hyprland** | `~/.config/hypr/` | Niri |
| **rofi** | `~/.config/rofi/` | DMS spotlight |
| **waybar** | `~/.config/waybar/` | DMS |
| **pyprland** | `~/.config/hypr/pyprland.toml` | Niri (no necesita) |
| **nwg-dock-hyprland** | `~/.config/nwg-dock-hyprland/style.css` | DMS |

### Plugins ZSH activos
auto-notify, git, jsontools, kitty, ssh, starship, web-search, zoxide, zsh-autosuggestions, zsh-bat, zsh-syntax-highlighting

---

## Archivos importantes de la dotfiles

| Archivo | Propósito |
|---|---|
| `~/.zshrc` | Shell config principal |
| `~/.bashrc` | Bash config (secundario) |
| `~/.gitconfig` | Git config con delta, nvimdiff, etc |
| `~/.config/kitty/kitty.conf` | Terminal |
| `~/.config/nvim/init.lua` | Neovim entry |
| `~/.config/lazygit/config.yml` | Git TUI |
| `~/.config/yazi/yazi.toml` | File manager |
| `~/.config/atuin/config.toml` | Shell history |
| `~/.config/swaylock/config` | Lock screen |
| `~/.config/swaync/config.json` | Notifications |
| `~/.config/wlogout/layout` | Power menu layout |
| `~/.config/swappy/config` | Screenshot editor |
| `~/.config/nwg-dock-hyprland/style.css` | Dock style (legacy) |

---

## Workflows comunes

### Regenerar config de niri
```zsh
cd ~/.config/niri && ./generate_config.sh minikom dms
```

### Actualizar dotfiles
```zsh
dotfiles status
dotfiles add <archivos>
dotfiles commit -m "mensaje"
dotfiles push
```

### Actualizar submodules (oh-my-zsh plugins)
```zsh
dotfiles submodule update --remote --recursive
```

### Setup post-clone en máquina nueva
```zsh
yay -S niri dms kitty swaylock swaync wlogout yazi lazygit atuin zoxide fzf mpv swappy niriswitcher
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
dotfiles submodule update --init --recursive
```
