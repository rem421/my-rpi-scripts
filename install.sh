#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[INFO] Starting Raspberry Pi 5 environment setup..."

echo "[INFO] Step 1/5: Installing SSH, mDNS, Git, GitHub CLI and TigerVNC..."
sudo apt update
sudo apt install -y openssh-server avahi-daemon git gh software-properties-common tigervnc-standalone-server xfce4 xfce4-goodies

echo "[INFO] Step 2/5: Enabling services and LAN firewall rules..."
sudo systemctl enable --now ssh avahi-daemon
sudo ufw allow ssh || true
sudo ufw allow from 192.168.1.0/24 || true

echo "[INFO] Step 3/5: Replacing Snap Firefox with native .deb (fixes VNC system.slice cgroup error)..."
sudo snap remove firefox || true
sudo add-apt-repository -y ppa:mozillateam/ppa
printf "Package: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001\n" | sudo tee /etc/apt/preferences.d/mozilla-firefox > /dev/null
sudo apt update
sudo apt install -y --allow-downgrades firefox
mkdir -p ~/.mozilla/firefox

echo "[INFO] Step 4/5: Installing VNC xstartup and GTK clipboard daemon..."
mkdir -p ~/.local/bin ~/.vnc ~/dev
cp "$SCRIPT_DIR/bin/rpi-clip-daemon.py" ~/.local/bin/rpi-clip-daemon.py
chmod +x ~/.local/bin/rpi-clip-daemon.py
cp "$SCRIPT_DIR/vnc/xstartup" ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

echo "[INFO] Step 5/5: Disabling GDM autologin (prevents Remote Login conflict)..."
if [ -f /etc/gdm3/custom.conf ]; then
  sudo sed -i "s/^AutomaticLoginEnable.*/AutomaticLoginEnable=false/" /etc/gdm3/custom.conf
fi

echo "[SUCCESS] RPi5 environment is ready. Start VNC with: vncserver :2 -geometry 1920x1080 -depth 24"
