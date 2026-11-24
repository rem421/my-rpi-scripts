# my-rpi-scripts

Scripts and remote desktop/environment configuration for Raspberry Pi 5 (Ubuntu 24.04 + XFCE/TigerVNC + ROS 2).

## Contents
- `bin/rpi-clip-daemon.py` – lightweight GTK3 (`GDK_BACKEND=x11`) daemon receiving clipboard updates from NixOS (Wayland/Niri) onto VNC display `:2`.
- `vnc/xstartup` – TigerVNC startup configuration (XFCE + `vncconfig` + forced X11 backend + `XDG_DATA_DIRS`).
- `install.sh` – installs dependencies (SSH, Avahi, Git, `gh`, TigerVNC, XFCE, native Firefox `.deb` replacing Snap), configures UFW rules, and installs scripts.

## Usage on a fresh RPi5
```bash
git clone <repo-url> ~/my-rpi-scripts
cd ~/my-rpi-scripts
./install.sh
```
