#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[INFO] Starting Raspberry Pi 5 environment setup..."

echo "[INFO] Step 1/4: Installing SSH, mDNS and TigerVNC..."
sudo apt update
sudo apt install -y openssh-server avahi-daemon tigervnc-standalone-server xfce4 xfce4-goodies

echo "[INFO] Step 2/4: Enabling services and LAN firewall rules..."
sudo systemctl enable --now ssh avahi-daemon
sudo ufw allow ssh || true
sudo ufw allow from 192.168.1.0/24 || true

echo "[INFO] Step 3/4: Installing VNC xstartup and GTK clipboard daemon..."
mkdir -p ~/.local/bin ~/.vnc ~/dev
cp "$SCRIPT_DIR/bin/rpi-clip-daemon.py" ~/.local/bin/rpi-clip-daemon.py
chmod +x ~/.local/bin/rpi-clip-daemon.py
cp "$SCRIPT_DIR/vnc/xstartup" ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

echo "[INFO] Step 4/4: Disabling GDM autologin (optional, prevents Remote Login conflict)..."
if [ -f /etc/gdm3/custom.conf ]; then
  sudo sed -i "s/^AutomaticLoginEnable.*/AutomaticLoginEnable=false/" /etc/gdm3/custom.conf
fi

echo "[SUCCESS] RPi5 environment is ready. Start VNC with: vncserver :2 -geometry 1920x1080 -depth 24"
