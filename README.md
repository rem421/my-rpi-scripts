# my-rpi-scripts

Scripts and remote desktop/environment configuration for Raspberry Pi 5 (Ubuntu 24.04 + XFCE/TigerVNC + ROS 2).

## Contents
- `bin/rpi-clip-daemon.py` – lightweight GTK3 (`GDK_BACKEND=x11`) daemon receiving clipboard updates from NixOS (Wayland/Niri) onto VNC display `:2`.
- `bin/rpi-panel-float.sh` – zero-CPU X11 RandR watcher keeping the XFCE top bar and bottom dock floating and centered on any TigerVNC window resize.
- `bin/apply-xfce-theme.sh` – applies the Material Design 3 XFCE/GTK/GNOME Terminal configuration (`Orchis-Purple-Dark-Compact`, `Tela-circle-purple-dark`, XRender compositing, CSD apps).
- `vnc/xstartup` – TigerVNC startup configuration (XFCE + `vncconfig` + `rpi-panel-float.sh` + forced X11 backend).
- `xfce/gtk.css` – custom GTK3 styling for floating solid dark bars, hover states, and rounded GNOME Terminal corners.
- `xfce/helpers.rc` – sets Nautilus, GNOME Terminal, and Firefox as default XFCE apps.
- `nautilus/Set as Wallpaper` – native Nautilus right-click script (Right-click -> Scripts -> Set as Wallpaper) to set XFCE wallpaper.
- `install.sh` – full bootstrap script for a fresh Raspberry Pi 5.

## Usage on a fresh RPi5
```bash
git clone <repo-url> ~/my-rpi-scripts
cd ~/my-rpi-scripts
./install.sh
```
After starting VNC (`vncserver :2 -geometry 1920x1080 -depth 24`), run `apply-xfce-theme.sh` once inside the XFCE session.
