# my-rpi-scripts

Skrypty i konfiguracja środowiska zdalnego dla Raspberry Pi 5 (Ubuntu 24.04 + XFCE/TigerVNC + ROS 2).

## Zawartość
- `bin/rpi-clip-daemon.py` – lekki daemon GTK3 (`GDK_BACKEND=x11`) przyjmujący schowek z NixOS (Wayland/Niri) na ekran VNC (`:2`).
- `vnc/xstartup` – konfiguracja startowa TigerVNC (XFCE + `vncconfig` + `XDG_DATA_DIRS`).
- `install.sh` – instalacja zależności (SSH, Avahi, Git, `gh`, TigerVNC, XFCE, natywny Firefox `.deb` zamiast Snapa), reguł UFW i kopiowanie skryptów.

## Użycie na świeżym RPi5
```bash
git clone <url-repo> ~/my-rpi-scripts
cd ~/my-rpi-scripts
./install.sh
```
